json.partial! '/api/v1/common'
json.partial! '/api/v1/shared/user', user: @user
json.access_token @access_token
json.device_uuid @device_uuid