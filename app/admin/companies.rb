ActiveAdmin.register Company do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  member_action :update_status, method: :put do
    resource.toggle(:approved)
    resource.save!
    redirect_to admin_companies_path
  end
  # permit_params :list, :of, :attributes, :on, :model
  actions :all, except: [:new, :edit]
  permit_params :company_name, :company_type, :contact_mail, :company_location, :company_state
  #config.filters = false
  filter :categories, collection: proc {(Category.all).map{|c| [c.category_name, c.id]}}
  filter :company_name
  remove_filter :jobs, :created_at, :updated_at, :company_state,
                :company_location, :company_type, :contact_mail, :approve
  # or
  #
  # permit_params do
  # permitted = [:permitted, :attributes]
  # permitted << :other if params[:action] == 'create' && current_user.admin?
  # permitted
 
  index do
    column :company_name
    column :company_type
    column :contact_mail
    column :company_location
    column :company_state
    # column "Categories Name" do |company|
    #   company.categories.map(&:category_name).uniq.join(",") 
    # end
    column :approved
    actions do |resource|
      text = resource.approved? ? 'Unapprove' : 'Approve'
      link_to text, update_status_admin_company_path(resource), method: :put
    end
  end
end
