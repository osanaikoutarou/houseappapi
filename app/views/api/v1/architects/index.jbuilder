json.partial! '/api/v1/common'
json.architects @architects do |architect|
  json.partial! '/api/v1/shared/architect', architect: architect
end