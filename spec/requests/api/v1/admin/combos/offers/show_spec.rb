describe 'GET /api/v1/admin/combos/:combo_id/offers/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:offer) { create(:offer, :with_combo) }

  before do
    get api_v1_admin_combo_offer_path(id: offer.hashid, combo_id: offer.combo.hashid),
        headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when offer exists' do
      include_examples 'have http status', :ok

      it 'returns queried offer' do
        expect(json[:data]).to include_json(
          hashid: offer.hashid,
          item_id: offer.item_id,
          discount: offer.discount
        )
      end
    end

    context 'when offer does not exist' do
      before do
        get api_v1_admin_combo_offer_path(id: 'gibberish', combo_id: 'gibberish'),
            headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
