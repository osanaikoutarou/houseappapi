json.partial! '/api/v1/common'
json.likes @likes
json.architects @architects do |architect|
  json.partial! '/api/v1/shared/architect', architect: architect
end