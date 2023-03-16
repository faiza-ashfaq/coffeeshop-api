describe 'PATCH /api/v1/admin/items/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:item) { create(:item) }
  let(:params) { {} }

  before do
    patch api_v1_admin_item_path(item.hashid), params: params, headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when item exists' do
      context 'when params are valid' do
        let(:params) do
          {
            item: {
              price: item.price + 2
            }
          }
        end

        include_examples 'have http status', :ok

        it 'returns the updated item' do
          expect(json[:data]).to include_json(
            hashid: item.hashid,
            title: item.title,
            price: format('%.2f', (item.price + 2)),
            tax_rate: item.tax_rate,
            description: item.description
          )
        end
      end

      context 'when params are invalid' do
        let(:params) do
          {
            item: {
              price: -2
            }
          }
        end

        include_examples 'have http status', :unprocessable_entity

        it 'returns attribute errors' do
          expect(json[:attributes_errors]).not_to be_empty
        end
      end
    end

    context 'when item does not exist' do
      before do
        patch api_v1_admin_item_path('gibbeirs'), params: params, headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
