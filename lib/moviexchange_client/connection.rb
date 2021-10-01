module MoviexchangeClient
  class Connection
    include HTTParty

    class << self
      def get_json(path, opts)
        url = generate_url(path, opts)
        response = get(url, format: :json)
        log_request_and_response url, response
        raise(MoviexchangeClient::RequestError.new(response)) unless response.success?
        response.parsed_response
      end

      def post_json(path, opts)
        no_parse = opts[:params].delete(:no_parse) { false }

        url = generate_url(path, opts[:params])
        response = post(url, body: opts[:body].to_json, headers: { 'Content-Type' => 'application/json' }, format: :json)
        log_request_and_response url, response, opts[:body]
        raise(MoviexchangeClient::RequestError.new(response)) unless response.success?

        no_parse ? response : response.parsed_response
      end

      def put_json(path, opts)
        url = generate_url(path, opts[:params])
        response = put(url, body: opts[:body].to_json, headers: { 'Content-Type' => 'application/json' }, format: :json)
        log_request_and_response url, response, opts[:body]
        raise(MoviexchangeClient::RequestError.new(response)) unless response.success?
        response.parsed_response
      end

      def delete_json(path, opts)
        url = generate_url(path, opts)
        response = delete(url, format: :json)
        log_request_and_response url, response, opts[:body]
        raise(MoviexchangeClient::RequestError.new(response)) unless response.success?
        response
      end

      def get_access_token(opts)
        base_url = opts[:auth_url]
        path = "/connect/token"
        url = base_url + path

        body = {
          "username" => opts[:username],
          "password" => opts[:password],
          "grant_type" => 'password',
          "client_id" => opts[:client_id]
        }

        headers = { 'Content-Type' => 'application/x-www-form-urlencoded' }

        response = post(url, body: body, headers: headers, format: :json)
        response['access_token']
      end

      protected

      def log_request_and_response(uri, response, body = nil)
        MoviexchangeClient::Config.logger.info "MoviexchangeClient: #{uri}.\nBody: #{body}.\nResponse: #{response.code} #{response.body}"
      end

      def generate_url(path, params = {}, options = {})
        path = path.clone
        params = params.clone
        base_url = options[:base_url] || MoviexchangeClient::Config.base_url

        params.each do |k, v|
          if path.match(":#{k}")
            path.gsub!(":#{k}", CGI.escape(v.to_s))
            params.delete(k)
          end
        end
        raise(MoviexchangeClient::MissingInterpolation.new("Interpolation not resolved")) if path =~ /:/

        query = params.map do |k, v|
          v.is_a?(Array) ? v.map { |value| param_string(k, value) } : param_string(k, v)
        end.join("&")

        path += path.include?('?') ? '&' : "?" if query.present?
        base_url + path + query
      end

      # convert into milliseconds since epoch
      def converted_value(value)
        value.is_a?(Time) ? (value.to_i * 1000) : CGI.escape(value.to_s)
      end

      def param_string(key, value)
        case key
        when /range/
          raise "Value must be a range" unless value.is_a?(Range)
          "#{key}=#{converted_value(value.begin)}&#{key}=#{converted_value(value.end)}"
        when /^batch_(.*)$/
          key = $1.gsub(/(_.)/) { |w| w.last.upcase }
          "#{key}=#{converted_value(value)}"
        else
          "#{key}=#{converted_value(value)}"
        end
      end
    end
  end

  # class FormsConnection < Connection
  #   follow_redirects true

  #   def self.submit(path, opts)
  #     url = generate_url(path, opts[:params], { base_url: 'https://forms.MoviexchangeClient.com'})
  #     post(url, body: opts[:body], headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
  #   end
  # end
end
