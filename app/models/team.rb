class Team < ApplicationRecord
  belongs_to :user
  has_many :talks
  has_many :channels
  validates :slug, :user, presence: true
end
