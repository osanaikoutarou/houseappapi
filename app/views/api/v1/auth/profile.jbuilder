json.partial! '/api/common'
json.partial! '/api/v1/shared/user', user: @user
json.partial! '/api/v1/shared/user_profile', user_profile: @user.try(:user_profile)