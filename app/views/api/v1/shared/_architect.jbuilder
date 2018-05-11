if architect.present?

  json.id architect.id
  json.name architect.name
  json.gender architect.gender
  json.hometown architect.hometown
  json.year_of_birth architect.year_of_birth
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
  json.avatar_url architect.avatar.url
  json.featured_photo do
    json.partial! '/api/v1/shared/photo', photo: architect.featured_photo
  end

  json.house_count architect.house_count
  json.photo_count architect.photo_count

  if current_user.present?
    json.liked FavoriteArchitect.exists?(user_id: current_user.id, architect_id: architect.id)
  end
end