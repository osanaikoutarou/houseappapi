json.partial! '/api/v1/common'
json.house do
  json.partial! '/api/v1/shared/house', house: @house
end

json.architect do
  json.partial! '/api/v1/shared/architect', architect: @house.architect
end
