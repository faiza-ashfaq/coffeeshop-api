json.user do
  json.extract! user, :id, :first_name, :last_name, :email, :locale, :created_at, :updated_at
end
