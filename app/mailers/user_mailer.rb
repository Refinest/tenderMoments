class UserMailer < ApplicationMailer
  def welcome(user_id)
    @user = User.find(user_id)
    return false if @user.nil?
    mail(from: '小美好 <admin@xiaomeihao.app>', to: @user.email, subject: '欢迎来到小美好！')
  end
end
