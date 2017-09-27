if photos.present?

  json.photos photos do |photo|
    json.partial! '/api/v1/shared/photo', photo: photo
  end
end