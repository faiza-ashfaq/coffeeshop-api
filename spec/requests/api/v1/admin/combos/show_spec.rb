describe 'GET /api/v1/admin/items/:id', skip_request: true do
  let(:user) { create(:user, :admin) }
  let(:combo) { create(:combo) }

  before do
    get api_v1_admin_combo_path(combo.hashid), headers: headers, as: :json
  end

  it_behaves_like 'an admin-authorized endpoint'

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when combo exists' do
      include_examples 'have http status', :ok

      it 'returns queried combo data' do
        expect(json[:data]).to include_json(
          hashid: combo.hashid,
          item_id: combo.item_id,
          quantity: combo.quantity
        )
      end
    end

    context "when combo doesn't exist" do
      before do
        get api_v1_admin_combo_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    it_behaves_like 'an authenticated endpoint'
  end
end
