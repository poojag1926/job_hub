class ProfessionalDetail < ApplicationRecord
	belongs_to :user, dependent: :destroy
	validates :job_role, :job_technology, :experience, presence: { message: "must be given please" }
	validates :current_ctc, presence: true, numericality: true
end
