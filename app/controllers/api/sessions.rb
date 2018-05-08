module API
  class Sessions < Grape::API
    include API::Authentication

    desc '登录用户', consumes: ['application/x-www-form-urlencoded'], tags: ['用户']
    params do
      requires :username, type: String, desc: '用户名或邮箱'
      requires :password, type: String, desc: '密码'
    end
    post '/users/sign_in' do
      username = params[:username]
      password = params[:password]
      user = User.find_by(username: username)
      
      error!({ error_code: 404, error_message: "用户名不存在" }) if user.nil?
      if !user.valid_password?(password)
        error!({ error_code: 404, error_message: "用户名或密码不正确" })
      else
        user.ensure_authentication_token!
        user.save!
        warden.set_user(user)
        { status: 'ok', token: user.authentication_token }.to_json
      end
    end

    desc '登出用户', tags: ['用户']
    # params do
    #   requires :token, type: String, desc: "Authenticaiton Token"
    # end
    delete '/users/sign_out' do
      if current_user.nil?
         error!({ error_code: 500, error_message: "No user logged in." })
      else
        warden.logout
        { status: 'ok'}
      end

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

    desc '查看当前用户', tags: ['用户']
    get '/user' do
      user = current_user
      { username: user.username } if user
    end
  end
end
