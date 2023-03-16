describe 'DELETE /api/v1/items/:item_id/destroy', skip_request: true do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:cart) { create(:cart, user: user) }
  let(:cart_item) { create(:cart_item, cart: cart) }

  before do
    delete api_v1_item_destroy_path(cart_item.item.hashid), headers: headers, as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when cart item exists' do
      include_examples 'have http status', :no_content
    end

    context 'when cart item does not exist' do
      before do
        delete api_v1_item_destroy_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
