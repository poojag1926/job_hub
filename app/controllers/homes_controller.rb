class HomesController < ApplicationController
	require 'will_paginate/array'
	before_action :set_search
  def index
  	@jobs = Job.where(status: 'published').last(5)
  	@jobs = @jobs.paginate(page: params[:page], per_page: 5)
  end
end
