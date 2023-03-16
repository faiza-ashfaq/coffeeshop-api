describe 'GET /api/v1/orders', skip_request: true do
  let(:user) { create(:user) }

  before do
    get api_v1_orders_path, headers: headers, as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :ok

    it 'returns list of paginated orders' do
      expect(json[:data]).to include_json(
        current_page: 1,
        items_on_page: 20,
        total_pages: 1,
        orders: []
      )
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
