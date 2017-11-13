json.partial! '/api/v1/common'
json.page @page
json.per_page @per_page
json.total @total

json.houses @houses do |house|
  json.partial! '/api/v1/shared/house', house: house
end
