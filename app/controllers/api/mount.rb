require 'grape-swagger'

module API
  class Mount < Grape::API
    format :json
    default_format :json

    mount Diaries

    add_swagger_documentation
  end
end