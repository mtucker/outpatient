class RemoveAddColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :add_column
  end
end
