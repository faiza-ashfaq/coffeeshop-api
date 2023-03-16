json.status 200

json.data do
  json.partial! 'combo', combo: @combo
end
