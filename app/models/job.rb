class Job < ApplicationRecord
	after_create :users_to_be_notify
	belongs_to :user, foreign_key: 'manager_id'
	has_many :applied_jobs
	has_many :users, through: :applied_jobs
	belongs_to :company
	belongs_to :category
	scope :by_status, -> (search){where('status ILIKE ?', "%#{search}%")}
	scope :published, -> {where(status: 'published')}

	def users_to_be_notify
		users = User.notifying_users
		users1 = users.select { |u| u.require_category_updates.include?(self.category_id.to_s)}
		users1.each do |user|
			JobMailer.with(job: self, job_seeker: users1).send_job_updates.deliver_now
		end	
	end	
end
