class AddApproveToCompany < ActiveRecord::Migration[5.2]
  def change
  	add_column :companies, :approve, :boolean
  end
end
