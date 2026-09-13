class Response < ApplicationRecord
  belongs_to :attendee
  belongs_to :candidate

  enum status: { ng: 0, ok: 1, pending: 2 }

  validates :status, presence: true
end