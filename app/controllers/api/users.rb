module API
  class Users < Grape::API
    helpers SharedParams

    resource :users do
      desc '获取用户个人信息', tags: ['用户'], detail: '传入用户名，返回用户个人信息'
      route_param :username, type: String do
        get do
          user = User.find_by(username: params[:username])
          present user, with: API::Entities::User
        end
      end
    end

    desc '修改用户个人信息', consumes: ['application/x-www-form-urlencoded'], tags: ['用户']
    params do
      use :user
    end
    post 'settings' do
      authenticate_user!
      present current_user, with: API::Entities::User if current_user.update declared(params)
    end
  end
end
