module API::SharedParams
  extend Grape::API::Helpers

  params :user do
    optional :nickname, desc: '用户昵称'
    optional :city, desc: '城市'
    optional :gender, values: %w(男 女 保密), desc: '性别'
    optional :qq, desc: 'QQ'
    optional :wechat, desc: '微信'
  end

  params :diary do
    requires :title, desc: '日记标题'
    requires :content, desc: '日记内容'
    optional :mood, desc: '心情'
    optional :weather, desc: '天气'
  end
end