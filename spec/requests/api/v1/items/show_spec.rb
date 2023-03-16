describe 'GET /api/v1/items/:id', skip_request: true do
  let(:user) { create(:user) }
  let(:item) { create(:item) }

  before do
    get api_v1_item_path(item.hashid), headers: headers, as: :json
  end

  context 'when user is authenticated' do
    let(:headers) { auth_headers }

    context 'when item exists' do
      include_examples 'have http status', :ok

      it 'returns the queried item' do
        expect(json[:data]).to include_json(
          hashid: item.hashid,
          title: item.title,
          price: format('%.2f', item.price),
          tax_rate: item.tax_rate,
          description: item.description
        )
      end
    end

    context "when item doesn't exist" do
      before do
        get api_v1_item_path('gibberish'), headers: headers, as: :json
      end

      include_examples 'have http status', :not_found
    end
  end

  context 'when user is not authenticated' do
    include_examples 'have http status', :ok

    it 'returns the queried item' do
      expect(json[:data]).to include_json(
        hashid: item.hashid,
        title: item.title,
        price: format('%.2f', item.price),
        tax_rate: item.tax_rate,
        description: item.description
      )
    end
  end
end
