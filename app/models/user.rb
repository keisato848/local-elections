class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates password:, format: {with: VALID_PASSWORD_REGEX}
  validates :nickname,  presense: true, uniquness: true

  private
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)\w{6,12}\z/.freeze
end
