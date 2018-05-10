class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :diaries, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: 3..16
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true # Allow only letter, number, underscore and punctuation.

  after_create :send_welcome_mail

  def send_welcome_mail
    UserMailer.welcome(id).deliver_later
  end

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
