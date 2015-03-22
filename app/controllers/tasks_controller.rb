class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]
    @task.save
    render :layout => false
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render :nothing => true
  end

  private
    def task_params
      params.require(:task).permit(:name)
    end
end
