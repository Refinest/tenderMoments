module API
  module Helpers
    def authenticate_user!
      error!({ error_code: 401, error_message: "当前没有用户登录" }, 401) unless current_user
    end
  end
end  