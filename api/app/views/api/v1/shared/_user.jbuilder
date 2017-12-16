unless user.nil?
  json.user do
    json.id user.id
    json.email user.email
  end
end