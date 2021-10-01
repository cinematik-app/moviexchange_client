describe MoviexchangeClient::TicketType do
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
    cassette "ticket_types"
    subject(:ticket_types) { MoviexchangeClient::TicketType.find_with_ticket_types_by_chain_and_showtime_id('6e66f9df-6c6f-4a09-877c-1e77ae5e426e', '83bf2953-dc25-4d2b-fec3-08d8fef9d29d') }

    it "should have a list of site for the chain" do
      expect(ticket_types).to be_a_kind_of Array
      expect(ticket_types.count).to eq(4)
      expect(ticket_types[0]['id']).to eq('0001')
      expect(ticket_types[0]['description']).to eq('Adult')
      expect(ticket_types[0]['isAllocatedSeating']).to be_truthy

    end
  end
end
