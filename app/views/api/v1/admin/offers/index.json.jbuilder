json.status 200

json.data do
  json.offers do
    json.array! @offers, partial: 'offer', as: :offer
  end

  json.current_page @pagy.page
  json.items_on_page @pagy.items
  json.total_pages @pagy.pages
end
