class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token 
  # before_action :require_manager_comapny
  def after_sign_in_path_for(resource)
    if resource.class.name.eql?('AdminUser')
      super
    elsif resource.is_manager? and resource.company?
      root_path
    elsif resource.is_manager?
      unless resource.company?
        redirect_to new_company_path
      end
    else
      super
    end 
  end

  protected
  def require_manager_comapny
    if current_user
      unless current_user.company?
        flash[:notice] = 'You need to create company first.'    
        redirect_to new_company_path
      end
    end      
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :username, :contact_no, :role,
                              :city, :state, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email_updates, :require_category_updates, :image, :resume, :full_name, :contact_no,
                              :city, :state, :username, :email, :password, :password_confirmation,
                              professional_details_attributes: [:id, :job_role, :job_technology, :current_ctc, 
                              :experience, :company, :_destroy]
                              ])
  end
   
  def set_search
    @q=Job.search(params[:q])
  end
 
end
