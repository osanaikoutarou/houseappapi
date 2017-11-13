json.partial! '/api/v1/common'
json.likes @likes
json.architects @architects do |architect|
  json.partial! '/api/v1/shared/architect', architect: architect

  json.matching do
    json.photo_likes_count architect.count_photo_likes_from_user(@user.id)
    json.house_likes_count architect.count_house_likes_from_user(@user.id)
  end
end