describe MoviexchangeClient::ShowTime do
  before do
    MoviexchangeClient.configure(
      auth_url: "https://www.example.com",
      base_url: "https://www.example.com",
      username: "xxx+2@xxx.com",
      password: "ASillyPassword123",
      client_secret: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'
    )
  end

  describe ".find_by_show_time_id" do
    cassette "show_times"
    subject(:show_time) { MoviexchangeClient::ShowTime.find_by_show_time_id('83bf2953-dc25-4d2b-fec3-08d8fef9d29d') }

    it "should find a specific site" do
      expect(show_time).to be_a_kind_of MoviexchangeClient::ShowTime
      expect(show_time['id']).to eq('83bf2953-dc25-4d2b-fec3-08d8fef9d29d')
      expect(show_time['screenName']).to eq('Cinema 3')
      expect(show_time['isAllocatedSeating']).to be_truthy
      expect(show_time['attributes']).to be_a_kind_of Array
    end
  end

  describe ".find_by_cinema_chain_id" do
    cassette "show_times"
    subject(:show_times) { MoviexchangeClient::ShowTime.find_by_site_id('dad76795-6bca-4788-568f-08d561ec8a55') }

    it "should have a list of site for the chain" do
      expect(show_times).to be_a_kind_of Array
      expect(show_times.count).to eq(561)
      expect(show_times[0]['id']).to eq('83bf2953-dc25-4d2b-fec3-08d8fef9d29d')
    end
  end

  describe ".find_with_ticket_types_by_site_id" do
    cassette "show_times"
    subject(:show_times) { MoviexchangeClient::ShowTime.find_with_ticket_types_by_site_id('dad76795-6bca-4788-568f-08d561ec8a55') }

    it "should have a list of site for the chain" do
      expect(show_times).to be_a_kind_of Array
      expect(show_times.count).to eq(561)
      expect(show_times[0]['ticketTypes'][0]['description']).to eq('Adult')
    end
  end
end
