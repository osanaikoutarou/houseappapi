json.partial! '/api/v1/common'

json.photos @photos do |photo|
  json.photo do
    json.partial! '/api/v1/shared/photo', photo: photo
  end

  json.house photo.house

  json.architect do
    json.partial! '/api/v1/shared/architect', architect: photo.architect
  end
end

