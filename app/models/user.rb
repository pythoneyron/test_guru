class User < ApplicationRecord
  has_many :users_tests
  has_many :tests, through: :users_tests

  def tests_by_level(level)
    tests.where(level: level)
    # Test.joins('INNER JOIN users_tests ON users_tests.test_id = tests.id')
    #   .where('tests.level = :level', level: level).where(users_tests: { user_id: self.id })
  end
end
