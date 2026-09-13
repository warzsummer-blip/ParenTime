class Event < ApplicationRecord
  belongs_to :user

  has_many :candidates, dependent: :destroy
  has_many :attendees, dependent: :destroy

  has_secure_token

  validates :title, presence: true
end