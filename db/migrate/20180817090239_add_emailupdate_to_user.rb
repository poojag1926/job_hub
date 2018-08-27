class AddEmailupdateToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :email_updates, :boolean
  	add_column :users, :require_category_updates, :text, array:true, default: []
  end
end
