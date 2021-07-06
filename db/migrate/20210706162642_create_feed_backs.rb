class CreateFeedBacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feed_backs do |t|
      t.string :name
      t.string :email, null: false
      t.string :header, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
