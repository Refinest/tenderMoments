class User < ApplicationRecord
  has_many :diaries, dependent: :destroy
end
