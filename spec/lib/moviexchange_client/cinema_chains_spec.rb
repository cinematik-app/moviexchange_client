describe MoviexchangeClient::CinemaChain do
  before do
    MoviexchangeClient.configure(
      auth_url: "https://www.example.com",
      base_url: "https://www.example.com",
      username: "xxx+2@xxx.com",
      password: "ASillyPassword123",
      client_secret: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'
    )
  end

  describe ".list" do
    cassette "cinema_chains"
    subject(:cinema_chains) { MoviexchangeClient::CinemaChain.list }

    it "should have a list of cinema chains" do
      expect(cinema_chains.count).to eq(4)
    end
  end

  describe ".find_by_cinema_chain_id" do
    cassette "cinema_chains"
    subject(:cinema_chain) { MoviexchangeClient::CinemaChain.find_by_cinema_chain_id('d90b9017-1abd-e711-80c2-000d3ad0511b') }

    it "should find a specific chain" do
      expect(cinema_chain['id']).to eq('d90b9017-1abd-e711-80c2-000d3ad0511b')
    end
  end
end
