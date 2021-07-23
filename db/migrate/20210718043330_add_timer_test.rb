class AddTimerTest < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :timer, :time
  end
end
