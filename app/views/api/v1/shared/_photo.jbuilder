if photo.present?
  json.id photo.id
  json.house_id photo.house_id
  json.image_url photo.image_url
  json.title photo.title
  json.description photo.description
  json.featured_photo photo.featured_photo

  json.house photo.house
  json.partial! '/api/v1/shared/architect', architect: photo.architect
end