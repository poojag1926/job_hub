class AddOwneridToCompany < ActiveRecord::Migration[5.2]
  def change
  	add_column :companies, :owner_id, :integer
  end
end
