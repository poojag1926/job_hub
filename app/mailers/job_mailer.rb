class JobMailer < ApplicationMailer
	default from: 'jobhub@gmail.com'
	def inform_manager_email
		@job = params[:job]
		@seeker = params[:job_seeker]
		@manager = @job.user
    
		mail(to: @manager.email, subject: 'User has applied for Job.')
  end

  def confirmation_user_email
  	@current_user = params[:job_seeker]
  	@job = params[:job]
  	@url = 'http://localhost:3000/users/sign_in'
  	mail(to: @current_user, subject: 'You have applied successfully for job.' )

  end

  def send_job_updates
    @job = params[:job]
    @job_seeker = params[:job_seeker]
    mail(to: @job_seeker, subject: 'New related job has been created.')


    
  end
end
