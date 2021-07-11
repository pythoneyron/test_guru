class Badge < ApplicationRecord
  has_many :user_badges
  has_many :users, through: :user_badges

  enum rule: { successful_completion_of_all_tests_from_the_Backend_category: 'success_backend',
               passing_the_test_successfully_on_the_first_try: 'success_on_first_try',
               successful_completion_of_all_tests_of_a_certain_level: 'success_certain_level'
  }
end
