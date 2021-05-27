class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  belongs_to :author, class_name: 'User', foreign_key: :author_id

  scope :simple_level, -> { where(level: 0..1) }
  scope :average_level, -> { where(level: 2..4) }
  scope :high_level, -> { where(level: 5..Float::INFINITY) }

  scope :by_level, ->(level) { where(level: level) } # Этот скоуп перенес сюда от модели пользователей,
                                                     # так как это имеет отношение к тестам

  scope :by_category_name, ->(category) {
    joins(:category).where(categories: { title: category })
                    .order(id: :desc).pluck('tests.title')
  }
end
