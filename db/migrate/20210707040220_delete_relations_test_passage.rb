class DeleteRelationsTestPassage < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :test_passages, column: :test_id
  end
end
