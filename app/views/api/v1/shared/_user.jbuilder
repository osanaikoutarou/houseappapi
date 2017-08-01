unless user.nil?
  json.user do
    json.id user.id
    json.email user.email
    json.role user.role
  end
end