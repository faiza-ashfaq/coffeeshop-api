json.status 200

json.data do
  json.partial! 'order', order: @order
end
