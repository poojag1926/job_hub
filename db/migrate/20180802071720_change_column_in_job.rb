class ChangeColumnInJob < ActiveRecord::Migration[5.2]
  def change
  	rename_column :jobs, :job_post, :title
  	rename_column :jobs, :job_experience, :req_experience
  	rename_column :jobs, :job_ctc, :offer_ctc
  	rename_column :jobs, :job_contactperson, :contact_person
  	rename_column :jobs, :contact_no, :contact_person_no
  	rename_column :jobs, :job_location, :location
  	rename_column :jobs, :job_vacancies, :no_of_vacancies
  	remove_column :jobs, :job_company

  end
end
