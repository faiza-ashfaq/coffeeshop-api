describe 'POST /api/v1/admin/combos/:combo_id/offers', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:item) { create(:item) }
  let(:combo) { create(:combo) }
  let(:offer) { build(:offer, combo: combo, item: item) }
  let(:params) { {} }

  before do
    post api_v1_admin_combo_offers_path(combo_id: combo.hashid), params: params, headers: headers,
                                                                 as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when params are valid' do
      let(:params) do
        {
          offer: {
            item_id: offer.item.hashid,
            discount: offer.discount
          }
        }
      end

      include_examples 'have http status', :ok

      it 'returns created offer' do
        expect(json[:data]).to include_json(
          item_id: offer.item.id,
          discount: offer.discount
        )
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          offer: {
            item_id: nil,
            discount: -10
          }
        }
      end

      include_examples 'have http status', :unprocessable_entity

      it 'returns attributes errors' do
        expect(json[:attributes_errors]).not_to be_empty
      end
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
