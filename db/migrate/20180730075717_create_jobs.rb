class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
    	t.string :job_post
    	t.string :job_experience
    	t.string :job_company
    	t.string :job_ctc
      t.string :job_contactperson
      t.string :contact_no
      t.string :job_location
      t.string :job_vacancies
      t.references :company, foreign_key: true
      

      t.timestamps
    end
  end
end
