ActiveAdmin.register Job do
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  actions :all, except:[:new,:edit, :destroy]
  permit_params :title, :req_experience, :offer_ctc,
                :contact_person, :contact_person_no, :location,
                :no_of_vacancies, :company_id, :category_id, :status
  filter :company, collection: proc {(Company.all).map{|c| [c.company_name, c.id]}}
  filter :category, collection: proc{(Category.all).map{|c| [c.category_name, c.id]}}
  filter :title
  filter :status
  # remove_filter :created_at, :updated_at, :job_name, :job_post, 
  #             :job_vacancies, :contact_no, :job_experience,
  #             :job_company, :job_ctc, :job_contactperson
  # permit_params do
	#   permitted = [:permitted, :attributes]
	#   permitted << :other if params[:action] == 'create' && current_user.admin?
	#   permitted
	# end

	# form do |f|

		
 #    f.inputs do
 #      f.input :title
 #      f.input :req_experience
 #      f.input :offer_ctc
 #      f.input :contact_person
 #      f.input :contact_person_no
 #      f.input :location
 #      f.input :no_of_vacancies
 #      f.input :company_id, collection: proc {(Company.all).map{|c| [c.company_name, c.id]}}
 #      f.input :category_id
 #    end
 #    f.actions
 #    end

  index do
    selectable_column
      column :title
      column :req_experience
      column :offer_ctc
      column :contact_person
      column :contact_person_no
      column :location
      column :no_of_vacancies
      column :status
      column :company_id
      column 'Company Name' do |job|
        job.company.company_name
      end
      actions
  end
end
