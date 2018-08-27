class AddUseridToJob < ActiveRecord::Migration[5.2]
  def change
  	add_column :jobs, :manager_id, :integer
  end
end
