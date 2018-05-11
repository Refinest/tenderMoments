module API
  module Entities
    class User < Base
      expose :username, documentation: 'unique username'
      expose :nickname
      expose :email
      expose :gender
      expose :city
      expose :qq
      expose :wechat
    end
  end
end