describe MoviexchangeClient::Site do
  before do
    MoviexchangeClient.configure(
      auth_url: "https://www.example.com",
      base_url: "https://www.example.com",
      username: "xxx+2@xxx.com",
      password: "ASillyPassword123",
      client_secret: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'
    )
  end

  describe ".find_by_site_id" do
    cassette "sites"
    subject(:site) { MoviexchangeClient::Site.find_by_site_id('e00aee11-d135-484c-ee73-08d51f55f8d5') }

    it "should find a specific site" do
      expect(site).to be_a_kind_of MoviexchangeClient::Site
      expect(site['id']).to eq('e00aee11-d135-484c-ee73-08d51f55f8d5')
      expect(site['name']).to eq('ABC Cinema 6')
      expect(site['cinemaChainId']).to eq('d90b9017-1abd-e711-80c2-000d3ad0511b')
    end
  end

  describe ".find_by_cinema_chain_id" do
    cassette "sites"
    subject(:sites) { MoviexchangeClient::Site.find_by_cinema_chain_id('d90b9017-1abd-e711-80c2-000d3ad0511b') }

    it "should have a list of site for the chain" do
      expect(sites.count).to eq(5)
      expect(sites[0]['name']).to eq('ABC Cinema 6')
    end
  end
end
