class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@user = current_user
	end

	def show 
		@user = User.find(params[:id])
	end 
end