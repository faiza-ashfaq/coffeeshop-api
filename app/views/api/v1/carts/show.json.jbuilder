hash = Jbuilder.new do |json|
  json.sub_total @billing_details.sub_total
  json.discount @billing_details.discount
  json.total @billing_details.total
end
json.data do
  json.items do
    json.array! @items, partial: 'api/v1/cart_items/item', as: :cart_item
  end
  json.merge! hash
end
