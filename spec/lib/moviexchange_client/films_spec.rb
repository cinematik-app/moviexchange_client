describe MoviexchangeClient::Film do
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
    cassette "films"
    subject(:film) { MoviexchangeClient::Film.find_by_film_id('3b3b6db5-3e97-49f5-9268-00c5c224a95f') }

    it "should find a specific site" do
      expect(film).to be_a_kind_of MoviexchangeClient::Film
      expect(film['id']).to eq('3b3b6db5-3e97-49f5-9268-00c5c224a95f')
      expect(film['title']).to eq('Long Shot')
      expect(film['genres']).to be_a_kind_of Array
    end
  end

  describe ".find_by_cinema_chain_id" do
    cassette "films"
    subject(:films) { MoviexchangeClient::Film.find_by_cinema_chain_id('d90b9017-1abd-e711-80c2-000d3ad0511b') }

    it "should have a list of site for the chain" do
      expect(films.count).to eq(331)
      expect(films[0]['title']).to eq('Long Shot')
    end
  end
end
