json.partial! '/api/v1/common'
json.page @page
json.total @total

json.partial! '/api/v1/shared/photos', photos: @photos
