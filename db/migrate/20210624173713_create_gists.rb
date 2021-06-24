class CreateGists < ActiveRecord::Migration[6.1]
  def change
    create_table :gists do |t|
      t.string :question, null: false
      t.string :hash, null: false
      t.string :link_to_gist, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
