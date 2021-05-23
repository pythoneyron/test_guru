class CreateUsersTests < ActiveRecord::Migration[6.1]
  def change
    create_table :users_tests do |t|
      t.references :user, foreign_key: true
      t.references :test, foreign_key: true

      t.timestamps
    end

    # add_index :users_tests, %i[user_id test_id], unique: true
  end
end
