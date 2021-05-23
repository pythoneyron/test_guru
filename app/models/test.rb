class Test < ApplicationRecord
  # belongs_to :category

  # has_many :users_tests
  # has_many :users, through: :users_tests

  def self.by_category_name(category)
    # joins(:category).where(categories: { title: category }).order(id: :desc).pluck('tests.title')
    joins('INNER JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category }).order(id: :desc).pluck('tests.title')
  end
end
