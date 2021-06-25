class CreateGists < ActiveRecord::Migration[6.1]
  def change
    create_table :gists do |t|
      t.string :question
      t.string :hash_gist
      t.string :link_to_gist
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
