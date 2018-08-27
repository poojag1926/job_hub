class RegistrationsController < Devise::RegistrationsController
 
  def edit
    @professional_details = resource.professional_details.build unless current_user.is_manager?
  end
 
  def update
    if params[:enable_notification].present? && params[:require_category].present?
      if current_user.update(email_updates: params[:enable_notification])
        require_update_details
      end
    else
      super
    end  
  end

  private

  def require_update_details
    if current_user.email_updates.eql?(true)
      current_user.require_category_updates << params[:require_category]
    else
      current_user.require_category_updates.delete(params[:require_category])
    end
     current_user.save
  end  
  
  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end
end









# <div class="panel panel-default">
#   <div class="panel-heading">Job Details</div>
#   <div class="panel-body">
#     <p>These are the JOBS.</p>
#   </div>
#   <table class="table">