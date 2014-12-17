class Activity < ActiveRecord::Base

  belongs_to :pre_activity, class_name: "Activity", foreign_key: :previous_activity
  has_one :next_activity, class_name: "Activity", foreign_key: :previous_activity
  scope :master_activity, lambda{ where(previous_activity: nil) }
  belongs_to :user
  has_many :job_activities

end
