module API
  class Mount < Grape::API
    format :json
    default_format :json

    mount Diaries
  end
end