if architect.present?

  json.architect do
    json.id architect.id
    json.name architect.name
    json.affiliation architect.affiliation
    json.zip_code architect.zip_code
    json.prefecture architect.prefecture
    json.city architect.city
    json.address1 architect.address1
    json.address2 architect.address2
    json.latitude architect.latitude
    json.longitude architect.longitude
    json.qualifications architect.qualifications
    json.message architect.message
    json.introduction architect.introduction
    json.speciality architect.speciality
    json.career architect.career
    json.homepage architect.homepage
    json.avatar architect.avatar.url

    json.house_count architect.house_count
    json.house_likes_count architect.house_likes_count
  end
end