class UserMailer < ApplicationMailer

  def signup_welcome_email(user)
    @user = user
    mail(to: @user.email, subject: '【ケンチクカタチ】会員登録完了のお知らせ')
  end

  def reset_password_email(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: '【ケンチクカタチ】パスワード・リセット用リンク')
  end

  def inquiry_received_email(inquiry, email)
    @inquiry = inquiry
    mail(to: email, subject: 'お問い合わせありがとうございます')
  end

end