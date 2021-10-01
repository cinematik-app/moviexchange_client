describe MoviexchangeClient::Order do
  before do
    MoviexchangeClient.configure(
      auth_url: "https://www.example.com",
      base_url: "https://www.example.com",
      username: "xxx+2@xxx.com",
      password: "ASillyPassword123",
      client_secret: 'XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'
    )
  end

  let(:tickets_array) do
    [
      {
        "showtimeId" => '83bf2953-dc25-4d2b-fec3-08d8fef9d29d',
        "id" => '0001',
        "quantity" => 3
      },
      {
        "showtimeId" => '83bf2953-dc25-4d2b-fec3-08d8fef9d29d',
        "id" => '0003',
        "quantity" => 2
      },
    ]
  end

  let(:customer_details) do
    {
      "name" => "Bob Smith",
      "email" => "bob@example.com",
      "phone" => "555-5555",
      "loyalty" => nil
    }
  end

  describe ".create_with_tickets_by_cinema_chain_id" do
    cassette "orders"

    subject(:order) do
      MoviexchangeClient::Order.create_with_tickets_by_cinema_chain_id(
        '6e66f9df-6c6f-4a09-877c-1e77ae5e426e',
        tickets_array
      )
    end

    it "should find a specific site" do
      expect(order).to be_a_kind_of MoviexchangeClient::Order
      expect(order['id']).to eq('e790643d-7586-49a6-8478-b2b052c0035a')
      expect(order['cinemaChainId']).to eq('6e66f9df-6c6f-4a09-877c-1e77ae5e426e')
      expect(order['totalPrice']).to eq(52.0)
      expect(order['showtimes']).to be_a_kind_of Array
      expect(order['showtimes'][0]['seatsRequireSelection']).to eq(false)
    end
  end

  describe ".set_customer_details_by_cinema_chain_id" do
    cassette "orders"

    subject(:order) do
      MoviexchangeClient::Order.set_customer_details_by_cinema_chain_id(
        '6e66f9df-6c6f-4a09-877c-1e77ae5e426e',
        'e790643d-7586-49a6-8478-b2b052c0035a',
        customer_details
      )
    end

    it "should find a specific site" do
      expect(order.properties).to eq(nil)
    end
  end

  describe ".find_by_order_id" do
    cassette "orders"
    subject(:order) do
      MoviexchangeClient::Order.find_by_order_id(
        '6e66f9df-6c6f-4a09-877c-1e77ae5e426e',
        'e790643d-7586-49a6-8478-b2b052c0035a'
      )
    end

    it "should find a specific order" do
      expect(order).to be_a_kind_of MoviexchangeClient::Order
      expect(order['id']).to eq('e790643d-7586-49a6-8478-b2b052c0035a')
      expect(order['cinemaChainId']).to eq('6e66f9df-6c6f-4a09-877c-1e77ae5e426e')
      expect(order['totalPrice']).to eq(52.0)
      expect(order['showtimes']).to be_a_kind_of Array
      expect(order['showtimes'][0]['seatsRequireSelection']).to eq(false)
    end
  end
end
