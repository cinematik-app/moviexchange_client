RSpec.describe MoviexchangeClient do
  it "has a version number" do
    expect(MoviexchangeClient::VERSION).not_to be nil
  end

  describe "#configure" do
    it "delegates a call to MoviexchangeClient::Config.configure" do
      mock(MoviexchangeClient::Config).configure(
        {
          auth_url: "https://www.example.com",
          base_url: "https://www.example.com",
          username: "demo",
          password: "demo_password",
          client_secret: 'demo_client_secret'}
      )
      MoviexchangeClient.configure(
        {
          auth_url: "https://www.example.com",
          base_url: "https://www.example.com",
          username: "demo",
          password: "demo_password",
          client_secret: 'demo_client_secret'}
      )
    end
  end
end
