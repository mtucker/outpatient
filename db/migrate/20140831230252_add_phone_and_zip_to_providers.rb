class AddPhoneAndZipToProviders < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :zip_code, :string
  end
end
