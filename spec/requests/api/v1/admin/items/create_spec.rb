describe 'POST /api/v1/admin/items', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:item) { build(:item) }
  let(:params) { {} }

  before do
    post api_v1_admin_items_path, params: params, headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when params are valid' do
      let(:params) do
        {
          item: {
            title: item.title,
            price: item.price,
            tax_rate: item.tax_rate,
            description: item.description
          }
        }
      end

      include_examples 'have http status', :ok

      it 'returns created item' do
        expect(json[:data]).to include_json(
          title: item.title,
          price: format('%.2f', item.price),
          tax_rate: item.tax_rate,
          description: item.description
        )
      end
    end

    context 'when params are invalid' do
      let(:params) do
        {
          item: {
            title: nil
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
