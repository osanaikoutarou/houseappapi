if photo.present?
  json.id photo.id
  json.house_id photo.house_id
  json.image_url photo.image_url
  json.title photo.title
  json.description photo.description
  json.featured_photo photo.featured_photo

  if current_user.present?
    json.liked PhotoLike.exists?(user_id: current_user.id, photo_id: photo.id)
  end
end