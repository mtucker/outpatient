class AddIsActiveDefaultToUsers < ActiveRecord::Migration
  def change
    change_column_default(:users, :is_active, true)
  end
end
