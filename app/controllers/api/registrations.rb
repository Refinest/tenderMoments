module API
  class Registrations < Grape::API
    include API::Authentication
      desc '注册用户', consumes: ['application/x-www-form-urlencoded'], tags: ['用户']
      params do
        requires :username, type: String, desc: '用户名'
        requires :email, type: String, desc: '邮箱'
        requires :password, type: String, desc: '密码'
        requires :password_confirmation, type: String, desc: '确认密码'
      end
      post '/users' do
        user = User.create!(
          username: params[:username],
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        )
        user.save if user.valid?
        present user, with: API::Entities::User
    end
  end
end
