class AppliedJob < ApplicationRecord
	belongs_to :user, foreign_key: 'job_seeker_id'
	belongs_to :job
end
