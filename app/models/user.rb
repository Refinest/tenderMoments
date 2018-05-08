class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :diaries, dependent: :destroy

  # before_save :ensure_authentication_token!

  def ensure_authentication_token!
    self.authentication_token ||= generate_authentication_token
  end

  def remove_authentication_token!
    self.authentication_token = nil
    save!
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
