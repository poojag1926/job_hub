class AddIdToProfessionalDetail < ActiveRecord::Migration[5.2]
  def change
  	 add_column :professional_details, :user_id, :integer
  end
end
