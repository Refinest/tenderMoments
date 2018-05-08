module API
  class Mount < Grape::API
    format :json
    default_format :json
    version 'v1', using: :path

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

    add_swagger_documentation \
      base_path: '/api',
      mount_path: 'doc/swagger',
      doc_version: '0.0.2',
      info: {
        title: "小美好 API 文档",
        description: "前端：王治文<br />后端：任峻宏",
      },
      tags: [
        { name: '用户', description: '用户相关操作' },
        { name: '日记', description: '日记相关操作' }
      ]

  end
end