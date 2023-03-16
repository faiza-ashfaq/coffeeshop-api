describe 'PATCH /api/v1/admin/combos/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:combo) { create(:combo) }
  let(:params) { {} }

  before do
    patch api_v1_admin_combo_path(combo.hashid), params: params, headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when combo exists' do
      context 'when params are valid' do
        let(:params) do
          {
            combo: {
              quantity: combo.quantity + 1
            }
          }
        end

        include_examples 'have http status', :ok

        it 'returns updated combo' do
          expect(json[:data]).to include_json(
            hashid: combo.hashid,
            item_id: combo.item_id,
            quantity: combo.quantity + 1
          )
        end
      end

      context 'when params are invalid' do
        let(:params) do
          {
            combo: {
              quantity: -2
            }
          }
        end

        include_examples 'have http status', :unprocessable_entity

        it 'returns attributes errors' do
          expect(json[:attributes_errors]).not_to be_empty
        end
      end
    end

    context 'when combo does not exist' do
      before do
        patch api_v1_admin_combo_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
