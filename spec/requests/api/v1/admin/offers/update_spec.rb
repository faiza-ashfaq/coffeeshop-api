describe 'PATCH /api/v1/admin/combos/:combo_id/offers/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:item) { create(:item) }
  let(:offer) { create(:offer, item: item) }
  let(:params) { {} }

  before do
    patch api_v1_admin_offer_path(offer.hashid), params: params, headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when offer exists' do
      context 'when params are valid' do
        let(:params) do
          {
            offer: {
              discount: offer.discount + 2
            }
          }
        end

        include_examples 'have http status', :ok

        it 'returns updated offer' do
          expect(json[:data]).to include_json(
            item_id: item.id,
            discount: offer.discount + 2
          )
        end
      end

      context 'when params are invalid' do
        let(:params) do
          {
            offer: {
              discount: -2
            }
          }
        end

        include_examples 'have http status', :unprocessable_entity

        it 'returns attributes errors' do
          expect(json[:attributes_errors]).not_to be_empty
        end
      end
    end

    context "when offer doesn't exist" do
      before do
        patch api_v1_admin_offer_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
