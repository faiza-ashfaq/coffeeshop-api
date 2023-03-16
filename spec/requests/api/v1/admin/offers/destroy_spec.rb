describe 'DELETE /api/v1/admin/offers/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:offer) { create(:offer) }

  before do
    delete api_v1_admin_offer_path(offer.hashid), headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :no_content
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
