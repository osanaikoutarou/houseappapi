if architect.present?

  json.architect do
    json.id architect.id
    json.name architect.name
    json.description architect.description
    json.avatar architect.avatar
    json.policy architect.policy
    json.house_count architect.house_count
    json.house_liked_count architect.house_liked_count
  end
end