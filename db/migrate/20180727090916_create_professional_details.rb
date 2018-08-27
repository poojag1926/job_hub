class CreateProfessionalDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :professional_details do |t|
      t.string :full_name
      t.string :job_role
      t.string :job_technology
      t.string :current_ctc
      t.string :experience
      t.string :company
      t.string :city
      t.string :state
      t.timestamps
    end
  end
end
