json.partial! '/api/v1/common'
json.page @page
json.total @total

json.architects @architects do |architect|
  json.partial! '/api/v1/shared/architect', architect: architect
end