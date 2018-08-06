class Channel < ApplicationRecord
  has_many :messages, as: :messageable, dependent: :destroy
  belongs_to :user
  belongs_to :team
  validates :team, :user, presence: true
  validates :slug, presence: true,
            format: { with: /\A[a-zA-Z0-9]+\Z/ }

  validates_uniqueness_of :slug, scope: :team_id
end
