class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  
  has_many :teams
  has_many :messages
  has_many :talks, dependent: :destroy
  has_many :team_users
  has_many :member_teams, through: :team_users, source: :team
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  def my_teams
    self.teams + self.member_teams
  end
end
