json.partial! '/api/v1/common'
json.page @page
json.total @total

json.houses @houses do |house|

  json.id house.id
  json.name house.name
  json.archtect_id house.architect_id
  json.rank house.rank
  json.floor_space house.floor_space
  json.site_area_space house.site_area_space
  json.area house.area
  json.zip_code house.zip_code
  json.prefecture house.prefecture
  json.city house.city
  json.address1 house.address1
  json.address2 house.address2
  json.latitude house.latitude
  json.longitude house.longitude
  json.description house.description


  json.featured_photo  do
    json.partial! '/api/v1/shared/photo', photo: house.photos.first
  end
end
