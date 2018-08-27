class AddDescriptionToJob < ActiveRecord::Migration[5.2]
  def change
  	add_column :jobs, :description, :string
  	add_column :jobs, :published_at, :datetime
  	add_column :jobs, :req_qualification, :string
  end
end
