describe 'GET /api/v1/items', skip_request: true do
  let(:user) { create(:user) }

  before do
    get api_v1_items_path, headers: headers, as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :ok

    it 'returns list of items with pagination' do
      expect(json[:data]).to include_json(
        current_page: 1,
        items_on_page: 20,
        total_pages: 1,
        items: []
      )
    end
  end

  context 'when user is not authenticated' do
    include_examples 'have http status', :ok

    it 'returns list of items with pagination' do
      expect(json[:data]).to include_json(
        current_page: 1,
        items_on_page: 20,
        total_pages: 1,
        items: []
      )
    end
  end
end
