json.status 200

json.data do
  json.partial! 'item', cart_item: @cart_item
end
