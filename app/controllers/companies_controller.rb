class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
	def index
		@company = Company.all
	end
	
	def new
		@company = current_user.company? ? current_user.company : Company.new
	end

	def create
		@company = Company.new(company_params)
	  if @company.save
		  flash[:sucess]= 'Company Successfully Created.'
			redirect_to root_path
		else
		  render 'new'
		end
	end

	def edit
		@company = Company.find(params[:id])
	end

	def update
		@company = Company.find(params[:id])
		if @company.update(company_params)
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def show
		@company = Company.find(params[:id])
	end	

  private
	def company_params
	params.require(:company).permit(:company_name, :company_type, 
			:contact_mail, :company_location, :company_state, :owner_id)
	end
end
