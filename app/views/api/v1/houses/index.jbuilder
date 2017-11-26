json.partial! '/api/v1/common'
json.page @finder.page
json.per_page @finder.per_page
json.total @finder.total

json.houses @finder.results do |house|
  json.partial! '/api/v1/shared/house', house: house
end


