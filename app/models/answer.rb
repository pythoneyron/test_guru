class Answer < ApplicationRecord
  belongs_to :question
  scope :correct_answer, -> { where(correct: true) }

  validates :text, presence: true
end
