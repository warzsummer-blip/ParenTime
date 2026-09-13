class Candidate < ApplicationRecord
  belongs_to :event
  has_many :responses, dependent: :destroy

  validates :start_at, presence: true
  validates :end_at, presence: true
end