json.status 200

json.data do
  json.combos do
    json.array! @combos, partial: 'combo', as: :combo
  end

  json.current_page @pagy.page
  json.items_on_page @pagy.items
  json.total_pages @pagy.pages
end
