describe 'GET /api/v1/checkout', skip_request: true do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when cart is not empty' do
      before do
        create_list(:cart_item, 10, cart: cart)

        post api_v1_checkout_path, headers: headers, as: :json
      end

      include_examples 'have http status', :ok

      it 'returns created order details' do
        expect(json[:data]).to include_json(
          user_id: user.id,
          order_status: 'processing'
        )
      end
    end

    context 'when cart is empty' do
      before do
        post api_v1_checkout_path, headers: headers, as: :json
      end

      include_examples 'have http status with error',
                       :bad_request,
                       I18n.t('errors.order.cart_is_empty')
    end
  end

  context 'when user is not authenticated' do
    before do
      post api_v1_checkout_path, headers: headers, as: :json
    end

    it_behaves_like 'an authenticated endpoint'
  end
end
