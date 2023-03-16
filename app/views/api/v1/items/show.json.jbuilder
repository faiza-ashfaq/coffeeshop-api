json.status 200

json.data do
  json.partial! 'api/v1/items/item', item: @item
end
