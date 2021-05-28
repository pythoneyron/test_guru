class Answer < ApplicationRecord
  ANSWERS_LIMIT_ON_QUESTION = 4

  belongs_to :question
  scope :correct_answer, -> { where(correct: true) }

  validates :text, presence: true
  validate :validate_answers_limit_on_question

  private

  def validate_answers_limit_on_question
    errors.add('Answers on question too many') if question.answers.count >= ANSWERS_LIMIT_ON_QUESTION
  end
end
