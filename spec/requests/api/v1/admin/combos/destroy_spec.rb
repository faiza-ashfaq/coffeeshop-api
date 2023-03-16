describe 'DELETE /api/v1/admin/combos/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:combo) { create(:combo) }

  before do
    delete api_v1_admin_combo_path(combo.hashid), headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when combo exists' do
      include_examples 'have http status', :no_content
    end

    context 'when combo doesnt exist' do
      before do
        delete api_v1_admin_combo_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
