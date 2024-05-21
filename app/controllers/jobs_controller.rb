class JobsController < ApplicationController
  before_action :set_job, only: %i[ show update destroy ]
  before_action :authorized, only: %i[ update destroy ]

  # GET /jobs
  def index
    @jobs = Job.find_by user: @user.id

    render json: @jobs
  end

  # GET /jobs/1
  def show
    render json: @job
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.user = @user.id

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:outcome, :date_applied, :company, :title, :application_url, :resume_title, :interview, :interview_date, :time)
    end
end
