module API
  module Entities
    class User < Base
      expose :username
      expose :email
      expose :password
      expose :password_confirmation
    end
  end
end