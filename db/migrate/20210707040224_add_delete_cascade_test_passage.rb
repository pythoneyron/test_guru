class AddDeleteCascadeTestPassage < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key "test_passages", "tests", null: false, on_delete: :cascade
  end
end
