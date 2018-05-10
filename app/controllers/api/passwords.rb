module API
  class Passwords < Grape::API
    include API::Authentication

    desc '重置密码', consumes: ['application/x-www-form-urlencoded'], tags: ['用户'], detail: '重置密码（忘记密码）'
    params do
      requires :email, type: String, desc: '邮箱'
    end
    post '/users/password' do
      user = User.find_by_email(params[:email])
      if user.present?
        user.send_reset_password_instructions
        { status: 'ok', success_meesage: 'mail has sent.' }
      else
        error!({ error_code: 404, error_message: "无此用户" }, 404)
      end
    end

    desc '修改密码', consumes: ['application/x-www-form-urlencoded'], tags: ['用户'], detail: '修改当前登录用户的密码，修改成功后需要重新登录'
    params do
      requires :password, type: String, desc: '新密码', documentation: { type: "password" }
      requires :password_confirmation, type: String, desc: '确认新密码', documentation: { type: "password" }
    end

    put '/users/password' do
      authenticate_user!
      if params[:password] == params[:password_confirmation]
        current_user.update(password: params[:password])
      else
        error!({ error_code: 500, error_message: "两次输入密码不一致" })
      end
      { status: 'ok' }
    end 

  end
end