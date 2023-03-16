describe 'POST /api/v1/admin/combos', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:item) { create(:item) }
  let(:combo) { build(:combo, item: item) }
  let(:params) { {} }

  before do
    post api_v1_admin_combos_path, params: params, headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when params are valid' do
      let(:params) do
        {
          combo: {
            item_id: combo.item.hashid,
            quantity: combo.quantity
          }
        }
      end

      include_examples 'have http status', :ok

      it 'returns created combo' do
        expect(json[:data]).to include_json(
          item_id: combo.item_id,
          quantity: combo.quantity
        )
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          combo: {
            item_id: nil,
            quantity: combo.quantity
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
