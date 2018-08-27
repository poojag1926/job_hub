class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
    	t.string :company_name
    	t.string :company_type
    	t.string :contact_mail
    	t.string :company_location
    	t.string :company_state

      t.timestamps
    end
  end
end
