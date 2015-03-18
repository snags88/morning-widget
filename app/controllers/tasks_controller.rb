class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    @task.user_id = params[:user_id]
    @task.save
    redirect_to dashboard_path(@task.user)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to dashboard_path(@task.user)
  end

  private
    def task_params
      params.require(:task).permit(:name)
    end
end
