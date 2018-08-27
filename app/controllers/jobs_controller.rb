class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, except: [:index, :new, :create, :show, :job_applied]
  before_action :set_search

  def index
    jobs = (current_user and current_user.is_manager?) ? current_user.created_jobs : Job.published
    @q = jobs.ransack(params[:q])
    @jobs = @q.result.includes(:company, :category)
    @jobs = @jobs.paginate(page: params[:page], per_page: 2)
  end

  def new
    @job = Job.new
  end
  
  def create
    @job = current_user.created_jobs.new(job_params)
    if @job.save
      redirect_to jobs_path
      flash[:success] = "Job successfully created."
    else
      render :new
    end
  end
  
  def edit
    @job = Job.find(params[:id])
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
      flash[:success] = "Job successfully updated."
    else
      render :edit
    end
  end

  def update_status
    @job = Job.find(params[:id])
    if @job.update(status: params[:status])
      @job.update(published_at: Time.now) if params[:status].eql?('published')
    end
    @jobs = current_user.created_jobs
    flash[:success] = "Status Updated."
  end

  def job_applied
    @job = Job.find(params[:id])
    @applied_job = @job.applied_jobs.new(job_seeker_id: current_user.id)
    @user = @applied_job.user
    if current_user
      unless current_user.resume?
        flash[:info] = "You need to upload your resume first."
        redirect_to (edit_user_registration_path)
        return
      end  
    elsif @applied_job.save
      JobMailer.with(job: @job, job_seeker: current_user).inform_manager_email.deliver_now
      JobMailer.with(job: @job, job_seeker: current_user).confirmation_user_email.deliver_now
      flash[:success] = "Applied Successfully."
    else
      flash[:error] = "Try Again."
    end
    render root_path  
  end
  
  def show
    @job = Job.find(params[:id])
  end

  def destroy
    @job = current_user.created_jobs.find(params[:id])
    @job.destroy
    redirect_to jobs_path
      flash[:danger] = "Job successfully deleted."
  end

  private
  def job_params
    params.require(:job).permit(:title, :req_experience, :offer_ctc,
                      :contact_person, :contact_person_no, :location, :no_of_vacancies, :company_id, :category_id, :manager_id, :status, :description, :published_at, :req_experience, :req_qualification)
  end

  def set_job
    @job = current_user.created_jobs.where(id: params[:id]).first
    if @job.blank?
      flash[:notice] = 'Could not found job.'
      redirect_to jobs_path
    end 
  end     
end
