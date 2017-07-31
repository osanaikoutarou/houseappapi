json.partial! '/api/common'
if @user.present?
  json.user @user
  json.user_profile @user.user_profile
end
json.token @token