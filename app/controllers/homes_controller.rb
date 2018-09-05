class HomesController < ApplicationController
	require 'will_paginate/array'
	before_action :set_search
  def index
  	@jobs = Job.where(status: 'published').last(5)
  	@jobs = @jobs.paginate(page: params[:page], per_page: 5)
    if current_user
      @created_jobs = Job.unscoped.where(manager_id: current_user.id)
      @published_jobs = @created_jobs.published.count
      @total_jobs = @created_jobs.count
      @draft_jobs = @created_jobs.where(status: 'draft').count
      @closed_jobs = @created_jobs.where(status: 'closed').count
      @applied_users = AppliedJob.where(job_id: current_user.created_jobs.map(&:id)).map(&:user).count
    end
  end
end
