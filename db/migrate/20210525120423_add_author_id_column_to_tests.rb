class AddAuthorIdColumnToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :author_id, :integer
    add_foreign_key :tests, :users, column: :author_id
  end
end
