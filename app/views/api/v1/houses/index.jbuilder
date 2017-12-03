json.partial! '/api/v1/common'
json.page @finder.page
json.per_page @finder.per_page
json.total @finder.total

json.houses @finder.results do |house|
  json.partial! '/api/v1/shared/house', house: house

  json.top_photos house.photos.limit(8) do |photo|
    json.partial! '/api/v1/shared/photo', photo: photo
  end

  json.architect do
    json.partial! '/api/v1/shared/architect', architect: house.architect
  end

end


