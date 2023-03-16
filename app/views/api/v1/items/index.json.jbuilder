json.status 200

json.data do
  json.items do
    json.array! @items, partial: 'api/v1/items/item', as: :item
  end

  json.current_page @pagy.page
  json.items_on_page @pagy.items
  json.total_pages @pagy.pages
end
