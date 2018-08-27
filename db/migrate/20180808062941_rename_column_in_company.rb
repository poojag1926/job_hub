class RenameColumnInCompany < ActiveRecord::Migration[5.2]
  def change
  	rename_column :companies, :approve, :approved
  end
end
