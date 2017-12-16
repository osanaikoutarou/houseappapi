json.partial! '/api/v1/common'
json.page @finder.page
json.per_page @finder.per_page
json.total @finder.total

json.photos @finder.results do |photo|
  json.partial! '/api/v1/shared/photo', photo: photo
end


