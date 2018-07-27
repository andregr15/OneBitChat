class Message < ApplicationRecord
  belongs_to :messageable, polymorphic: true
  belongs_to :user
  validates :body, :user, presence: true
end
