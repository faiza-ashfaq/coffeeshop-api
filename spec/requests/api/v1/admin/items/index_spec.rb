describe 'GET /api/v1/admin/items', skip_request: true do
  let(:user) { create(:user, :admin) }

  before do
    get api_v1_admin_items_path, headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :ok

    it 'returns list of paginated items' do
      expect(json[:data]).to include_json(
        current_page: 1,
        items_on_page: 20,
        total_pages: 1,
        items: []
      )
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
