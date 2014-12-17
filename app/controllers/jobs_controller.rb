 
class JobsController < ApplicationController
  
  def index
    if current_user.id != 1
      redirect_to "/dashboard"
    end
    @jobs = Job.all.order("id desc").paginate(:page => params[:page])
  end
  
  
  def show
    if current_user.id != 1
      redirect_to "/dashboard"
    end
    @jobs = Job.select([:id, :name])
    @job = Job.where(id: params[:id]).first
    @master_activity = @job.job_activities.master_activity

  end


  def move_activity
    job = Job.where(id: params[:id]).first
    activity = job.job_activities.where(id: params[:job_activity_id]).first
    activity.move_action(params[:act_action])
    master_activities = job.job_activities.master_activity
    html = ""
    master_activities.each do  |master_activity|
      html << render_to_string(:partial => "activity.html.erb", :layout => false, locals: {activity: master_activity, job: job })
    end
    render json: {success: true, html: html} 
  end

  def new
    @job = Job.new
  end

  def create
    params.permit!
    job = Job.new(params[:job])
    job.save
    job.start_job
    redirect_to jobs_path(job)
  end

  def filter
    params.permit!
    job = Job.where(id: params[:job_id]).first
    activities=job.filter(params[:status])
    html=""
    html << render_to_string(:partial => "filter.html.erb", :layout => false, locals: {activities: activities, job: job })
    render json: {success: true, html: html} 
    end

  def filter_user_activity
    params.permit!
    if params[:status]=="NONE"
    @job_activities = JobActivity.where(user_id: current_user.id, status: ['PENDING', 'WIP', 'REJECTED']).order("id asc").paginate(:page => params[:page])
    elsif params[:status]=="ACTIVITY TYPE"
    @job_activities = JobActivity.where(user_id: current_user.id, status: ['PENDING', 'WIP', 'REJECTED']).order("activity_type asc").paginate(:page => params[:page])
    elsif params[:status]=="DATE"
    @job_activities = JobActivity.where(user_id: current_user.id, status: ['PENDING', 'WIP', 'REJECTED']).order("start_date asc").paginate(:page => params[:page])
    else
    @job_activities = JobActivity.where(user_id: current_user.id, status: ['PENDING', 'WIP', 'REJECTED']).order("status asc").paginate(:page => params[:page])
    end
    html=""
    html << render_to_string(:partial => "home/dashboard.html.erb", :layout => false, locals: {job_activities: @job_activities})
    render json: {success: true, html: html} 
  end

  def upload_activities
  end

  def upload_activities_save
     params.permit!
     book = Spreadsheet.open(params["upload"]["spreadsheet"].open, 'rb')
     Activity.destroy_all
     0.upto 1 do |sheet_no|
         sheet= book.worksheet(sheet_no)
         1.upto sheet.last_row_index do |index|
              row = sheet.row(index)
               activity=Activity.new
               activity.id=row[0]
               activity.activity_type=row[1]
               if row[2].to_i!=0
               activity.previous_activity=row[2]
               end
               activity.name=row[3]
               activity.duration=row[4]
               activity.user_id=row[7]
               activity.user_name=row[8]
               activity.save
          end
    end
      redirect_to activities_path
  end

  def activities
    @activities=Activity.all
  end
end
