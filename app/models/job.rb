class Job < ActiveRecord::Base
  has_many :job_activities

  after_create :create_job_activity
  
  
  def create_job_activity
    Activity.all.each do |activity|
      new_job_activity = self.job_activities.build({name: activity.name, activity_id: activity.id,  duration: activity.duration, user_id: activity.user_id, start_date: self.job_activities.last.try(:end_date) || self.start_date, end_date: (self.job_activities.last.try(:end_date) || self.start_date) + activity.duration.to_i, user_name: activity.user_name, is_background: activity.is_background, activity_type: activity.activity_type })

      
      
      new_job_activity.save
    end
    
    Activity.all.each do |activity|
      new_job_activity = self.job_activities.where(activity_id: activity.id).first
      new_job_activity.previous_activity = JobActivity.where(job_id: self.id, activity_id: activity.pre_activity).first.try(:id) if activity.previous_activity.present?
        
      new_job_activity.rejected_activity = JobActivity.where(job_id: self.id, activity_id: activity.rejected_activity).first.try(:id) if activity.rejected_activity.present?
      new_job_activity.save
    end
    
  end

  def start_job
    self.job_activities.master_activity.each do |master_act|
      master_act.update_attributes({status: "PENDING"})
   end
  end
    
  def filter(status)
    if status=="ALL"
    return self.job_activities.order("id asc")
    else
    return self.job_activities.where(status: status)
    end
  end
    

  
end
