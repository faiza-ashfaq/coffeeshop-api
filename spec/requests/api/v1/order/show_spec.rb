describe 'GET /api/v1/orders/:id', skip_request: true do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before do
    get api_v1_order_path(order.hashid), headers: headers, as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when order exists' do
      context 'when current user is order owner' do
        let(:order) { create(:order, user: user) }

        include_examples 'have http status', :ok

        it 'returns queried order data' do
          expect(json[:data]).to include_json(
            hashid: order.hashid,
            user_id: order.user_id,
            sub_total: format('%.1f', order.sub_total),
            discount: format('%.1f', order.discount),
            total: format('%.1f', order.total),
            order_status: order.order_status
          )
        end
      end

      context 'when current user is unauthorized' do
        include_examples 'have http status', :unauthorized
      end
    end

    context "when order doesn't exist" do
      before do
        get api_v1_order_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
