module API
  class Sessions < Grape::API
    include API::Authentication

    desc '登录用户', consumes: ['application/x-www-form-urlencoded'], tags: ['用户'], detail: "登录用户，并返回用户 token"
    params do
      requires :login, type: String, desc: '用户名或邮箱'
      requires :password, type: String, desc: '密码', documentation: { type: "password" }
    end
    post '/users/sign_in' do
      login = params[:login]
      password = params[:password]
      user = User.find_by "username = ? or email = ?", login, login

      error!({ error_code: 404, error_message: "用户名或邮箱不存在" }, 404) if user.nil?
      if !user.valid_password?(password)
        error!({ error_code: 404, error_message: "用户名或密码不正确" }, 404)
      else
        user.ensure_authentication_token!
        user.save!
        warden.set_user(user)
        { status: 'ok', token: user.authentication_token }
      end
    end

    desc '登出用户', tags: ['用户']
    # params do
    #   requires :token, type: String, desc: "Authenticaiton Token"
    # end
    delete '/users/sign_out' do
      authenticate_user!
      warden.logout
      { status: 'ok'}

      # user = User.find_by(authentication_token: params[:token])
      # if !user.nil?
      #   warden.logout
      #   user.remove_authentication_token!
      #   # status(200)
      #   {
      #     status: 'ok',
      #     token: user.authentication_token
      #   }
      # else
      #   error!({ error_code: 404, error_message: "Invalid token."}, 401)
      # end
    end

    desc '查看当前用户', tags: ['用户'], detail: '查看当前登录的用户，返回用户名'
    get '/user' do
      authenticate_user!
      { username: current_user.username }
    end
  end
end
