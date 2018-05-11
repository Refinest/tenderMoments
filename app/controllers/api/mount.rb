module API
  class Mount < Grape::API
    format :json
    default_format :json

    helpers ::API::Helpers
    include API::Authentication

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

    rescue_from :all do |e|
      error!({ error: e }, 500, { 'Content-Type' => 'text/error' })
    end
    # rescue_from :all, backtrace: true

    mount Diaries
    mount Registrations
    mount Sessions
    mount Passwords
    mount Users

    add_swagger_documentation \
      base_path: '/api',
      # base_path: '',
      mount_path: '/swagger_doc',
      doc_version: '0.0.4',
      info: {
        title: "小美好 API 文档",
        description: "前端：<img class='avatar' src='https://avatars2.githubusercontent.com/u/17549215?s=460&v=4'> 王治文<br />
        后端：<img class='avatar' src='https://avatars1.githubusercontent.com/u/19547819?s=460&v=4'> 任峻宏",
      },
      tags: [
        { name: '用户', description: '用户相关操作' },
        { name: '日记', description: '日记相关操作' }
      ]
  end
end