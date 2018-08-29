class Company < ApplicationRecord
	has_many :jobs, dependent: :destroy
	has_many :categories, through: :jobs
	belongs_to :user, foreign_key: 'owner_id'
	validates :company_name, presence: {message: 'please add'}

  def is_approved?
    self.approved.eql?(true)
  end
end
