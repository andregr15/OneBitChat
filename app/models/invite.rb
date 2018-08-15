class Invite < ApplicationRecord
  has_secure_token
  belongs_to :team

  validates :team, :email, presence: true
  
  validates :email, presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
end
