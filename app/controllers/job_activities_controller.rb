require 'Inform.rb'
class JobActivitiesController < ApplicationController

  def wip_job
    params.permit!
    job_activity = JobActivity.where(id: params[:id]).first
    job_activity.wip_job
    redirect_to "/dashboard"
  end

  def done_job
    params.permit!
    job_activity = JobActivity.where(id: params[:id]).first
    job_activity.done_job
    redirect_to "/dashboard"
  end

  def reject_job
    params.permit!
    job_activity = JobActivity.find_by_id(params[:rej_id])
    current_act = JobActivity.find_by_id(params[:current_act_id])
    job_activity.update_attributes(status: 'REJECTED', remark: params[:remarks], rejector_id: current_user.id)
    result = job_activity.job.job_activities.where('id > ? and id < ? and activity_type = ? and status IN (?)', job_activity.id,current_act.id ,job_activity.activity_type, ['DONE', 'PENDING', 'REJECTED', 'done'])
    current_act.update_attributes(status: 'CREATED')
    result.update_all(status: 'CREATED')
   

    #Send Mail of Rejection
    call= Inform.new
    call.sendTo("Rejected Activity-"+current_act.name+" by "+current_act.user_name,"Activity "+current_act.name+" is rejected by "+current_act.user_name+" on date: "+Date.today.to_s+" with Remark: "+params[:remarks])
    redirect_to "/dashboard"
  
  end
  
end
