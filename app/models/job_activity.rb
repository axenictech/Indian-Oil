class JobActivity < ActiveRecord::Base

  belongs_to :pre_activity, class_name: "JobActivity", foreign_key: :previous_activity
  has_one :next_activity, class_name: "JobActivity", foreign_key: :previous_activity
  belongs_to :job
  belongs_to :activity
  belongs_to :rejector, class_name: 'User', foreign_key: :rejector_id
  scope :master_activity, lambda{ where(previous_activity: nil) }
  scope :done_activity, -> (activity_type){ where(status: "DONE", activity_type: activity_type) }

  # validates :name, uniqueness: { scope: [:job_id, :activity_type] }, presence: true
  def id_name
   return self.activity_id.to_s+"-"+self.name
  end

  def move_next
    next_act = self.next_activity
    if next_act.present?
      next_act.update_attributes({start_date: self.start_date, end_date: self.start_date + next_act.duration.days})
      self.update_attributes({start_date: next_act.end_date, end_date: next_act.end_date + self.duration.days})

      next_next_act = next_act.next_activity
      self_pre_id = self.previous_activity
      next_pre_id = next_act.id
      
      self.update_attributes({previous_activity: next_pre_id})
      next_act.update_attributes({previous_activity: self_pre_id})

      if next_next_act.present?
        next_next_act.update_attributes({previous_activity: self.id})
      end
    end
  end
  
  def move_previous
    prev_act = self.pre_activity
    if prev_act.present?
      self.update_attributes({start_date: prev_act.start_date, end_date: prev_act.start_date + self.duration.days})
      prev_act.update_attributes({start_date: self.end_date, end_date: self.end_date + prev_act.duration.days})
      nxt_act = self.next_activity
      self_pre_id = self.previous_activity
      pre_pre_id = prev_act.previous_activity

      self.update_attributes({previous_activity: pre_pre_id})
      prev_act.update_attributes({previous_activity: self.id})
      
      if nxt_act.present?
        nxt_act.update_attributes({previous_activity: prev_act.id})
      end
    end
  end


  def move_action(action)
    if action == 'up'
      self.move_previous
    elsif action == 'down'
      self.move_next
    end
  end
  
  def done_job
    self.update_attributes!({status: "DONE"})
    if self.next_activity.present?
      self.next_activity.update_attributes({status: "PENDING"}) 
    end
  end

  def rejected_job(rej_id)
    rej_activity = self
    
    while rej_activity.id != rej_id
      rej_activity.update_attributes({status: "REJECTED", remark: "REJECTED ON #{self.activity.name}"})
      rej_activity = rej_activity.pre_activity
    end
    
    rej_activity.update_attributes({status: "PENDING", remark: "REJECTED ON #{self.activity.name}"})
  end

  def wip_job
    self.update_attributes({status: "WIP"})
  end

  
  
end
