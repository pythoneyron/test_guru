class AddIsAuthorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_author, :boolean
    # change_column_default :users, :is_author, false
  end
end
