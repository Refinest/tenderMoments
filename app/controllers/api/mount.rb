require 'grape-swagger'

module API
  class Mount < Grape::API
    format :json
    default_format :json
    version 'v1', using: :path

    mount Diaries

    add_swagger_documentation \
      base_path: '/api',
      mount_path: 'doc/swagger',
      doc_version: '0.0.1',
      info: {
        title: "小美好 API 文档",
        description: "前端：王治文<br />后端：任峻宏",
      }

  end
end