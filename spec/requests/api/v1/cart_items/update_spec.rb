describe 'PATCH /api/v1/items/:item_id/update', skip_request: true do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:cart_item) { create(:cart_item, cart: cart) }
  let(:params) { {} }

  before do
    patch api_v1_item_update_path(cart_item.item.hashid), params: params, headers: headers,
                                                          as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when cart_item exists' do
      context 'when incrementing a cart_item' do
        let(:params) { { action_type: 'increment' } }

        include_examples 'have http status', :ok

        it 'returns cart item with increased quantity' do
          expect(json[:data]).to include_json(
            quantity: cart_item.quantity + 1
          )
        end
      end

      context 'when decrementing a cart_item' do
        let(:params) { { action_type: 'decrement' } }

        include_examples 'have http status', :ok

        it 'returns cart item with decreased quantity' do
          expect(json[:data]).to include_json(
            quantity: cart_item.quantity - 1
          )
        end
      end

      context 'when paramter action_type is not send' do
        include_examples 'have http status', :bad_request
      end
    end

    context 'when cart item does not exist' do
      before do
        patch api_v1_item_update_path('gib'), params: params, headers: headers,
                                              as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
