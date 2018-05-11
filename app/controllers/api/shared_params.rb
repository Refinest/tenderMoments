module API::SharedParams
  extend Grape::API::Helpers

  params :user do
    optional :nickname, desc: '用户昵称'
    optional :city, desc: '城市'
    optional :gender, values: %w(男 女 保密), desc: '性别'
    optional :qq, desc: 'QQ'
    optional :wechat, desc: '微信'
  end
end