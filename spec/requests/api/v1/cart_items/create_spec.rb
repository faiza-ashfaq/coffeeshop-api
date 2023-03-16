describe 'POST /api/v1/items/:item_id/cart_items', skip_request: true do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:cart) { create(:cart, user: user) }

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when a new item that is being added' do
      before do
        post api_v1_item_cart_items_path(item.hashid), headers: headers, as: :json
      end

      include_examples 'have http status', :ok

      it 'returns created cart_item' do
        expect(json[:data]).to include_json(
          title: item.title,
          price: format('%.2f', item.price),
          tax_rate: item.tax_rate,
          description: item.description,
          quantity: 1
        )
      end
    end

    context 'when item that is being added is already in cart' do
      before do
        create(:cart_item, item: item, cart: cart)
        post api_v1_item_cart_items_path(item.hashid), headers: headers, as: :json
      end

      include_examples 'have http status', :unprocessable_entity

      it 'returns attribute errors' do
        expect(json[:attributes_errors]).to include_json(
          item_id: ['has already been taken']
        )
      end
    end
  end

  context 'when user is not authenticated' do
    before do
      post api_v1_item_cart_items_path(item.hashid), headers: headers, as: :json
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
