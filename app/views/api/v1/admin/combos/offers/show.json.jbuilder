json.status 200

json.data do
  json.partial! 'offer', offer: @offer
end
