json.partial! '/api/v1/common'
json.page @finder.page
json.per_page @finder.per_page
json.total @finder.total

json.architects @finder.results do |architect|
  json.partial! '/api/v1/shared/architect', architect: architect
end
