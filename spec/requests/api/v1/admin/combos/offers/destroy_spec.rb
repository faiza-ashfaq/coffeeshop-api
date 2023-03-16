describe 'DELETE /api/v1/admin/combos/:combo_id/offers/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:combo) { create(:combo) }
  let(:offer) { create(:offer, combo: combo) }

  before do
    delete api_v1_admin_combo_offer_path(id: offer.hashid, combo_id: combo.hashid),
           headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when offer exists' do
      include_examples 'have http status', :no_content
    end

    context 'when offer does not exist' do
      before do
        delete api_v1_admin_combo_offer_path(id: '', combo_id: ''),
               headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
