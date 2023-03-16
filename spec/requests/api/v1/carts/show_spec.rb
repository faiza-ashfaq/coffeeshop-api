describe 'GET /api/v1/carts', skip_request: true do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:cart) { create(:cart, user: user) }

  before do
    create(:cart_item, cart: cart, item: item)

    get api_v1_carts_path, headers: headers, as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    include_examples 'have http status', :ok

    it 'returns cart and cart_items' do
      expect(json[:data]).to include_json(
        sub_total: format('%.4f', cart.sub_total),
        discount: 0,
        total: format('%.4f', cart.sub_total),
        items: [{
          hashid: item.hashid,
          title: item.title, price: format('%.2f', item.price),
          tax_rate: item.tax_rate, description: item.description
        }]
      )
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
