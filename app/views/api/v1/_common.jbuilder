json.ignore_nil!
if @error.present?
  json.error_code @error.code
  json.error_message @error.message
end