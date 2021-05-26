class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  belongs_to :author, class_name: 'User', foreign_key: :author_id

  def self.by_category_name(category)
    joins(:category).where(categories: { title: category }).order(id: :desc).pluck('tests.title')
  end
end
