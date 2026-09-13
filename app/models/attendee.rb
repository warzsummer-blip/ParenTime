class Attendee < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true
  belongs_to :confirmed_candidate, class_name: 'Candidate', optional: true

  has_many :responses, dependent: :destroy
  accepts_nested_attributes_for :responses

  validates :parent_name, presence: true
  validates :child_name, presence: true
  validates :grade_class, presence: true
end