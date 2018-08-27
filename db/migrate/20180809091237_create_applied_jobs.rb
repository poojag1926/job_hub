class CreateAppliedJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :applied_jobs do |t|
      t.integer :job_seeker_id
  	  t.integer :job_id
      t.timestamps
    end
  end
end
