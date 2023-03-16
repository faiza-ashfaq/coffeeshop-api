describe 'DELETE /api/v1/admin/items/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:item) { create(:item) }

  before do
    delete api_v1_admin_item_path(item.hashid), headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when item exists' do
      include_examples 'have http status', :no_content
    end

    context 'when item does not exist' do
      before do
        delete api_v1_admin_item_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
