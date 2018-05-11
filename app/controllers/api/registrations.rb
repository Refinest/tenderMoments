module API
  class Registrations < Grape::API
    desc '注册用户', consumes: ['application/x-www-form-urlencoded'], tags: ['用户'], detail: '注册用户，成功后返回用户信息'
    params do
      requires :username, type: String, desc: '用户名'
      requires :email, type: String, desc: '邮箱'
      requires :password, type: String, desc: '密码', documentation: { type: "password" }
      requires :password_confirmation, type: String, desc: '确认密码', documentation: { type: "password" }
    end
    post '/users' do
      user = User.create! declared(params)
      { username: user.username, email: user.email }
    end
  end
end
