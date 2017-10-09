json.partial! '/api/v1/common'
json.page @page
json.total @total

json.photos @photos do |photo|
  json.photo do
    json.partial! '/api/v1/shared/photo', photo: photo
  end
end
