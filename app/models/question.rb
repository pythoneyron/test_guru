class Question < ApplicationRecord
  belongs_to :test
  has_many :answers

  validates :body, presence: true
  validate :validate_answers_limit

  private

  def validate_answers_limit
    errors.add(:answers, "too many") if answers.count > 4
  end
end
