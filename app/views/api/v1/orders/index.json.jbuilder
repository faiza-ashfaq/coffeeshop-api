json.status 200

json.data do
  json.orders do
    json.array! @orders, partial: 'order', as: :order
  end

  json.current_page @pagy.page
  json.items_on_page @pagy.items
  json.total_pages @pagy.pages
end
