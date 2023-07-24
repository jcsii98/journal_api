class TasksController < ApplicationController
before_action :check_authentication
before_action :set_user
before_action :set_category, except: [:due_today]
before_action :set_task, only: [:show, :update, :destroy]


def index
    @tasks = @category.tasks
    render json: @tasks.to_json
end

def show
    render json: @task
end
    
def create
    @task = @category.tasks.build(task_params)

    if @task.save
        render json: @task, status: :created
    else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
end

def update
    if @task.update(task_params)
        render json: @task
    else
        render json: {errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
end

def destroy
    if @task.destroy
        render json: { message: 'Task successfully deleted'}
    else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
end

def due_today
  # Add 8 hours to the current time to account for the time zone difference
  current_time_with_offset = Time.current + 8.hours

  # Extract the date portion from the adjusted time (excluding the time component)
  adjusted_date = current_time_with_offset.to_date

  # Find tasks that are due today in the adjusted time zone
  @tasks = Task.where(due_date: adjusted_date)

  render json: @tasks, include_category: true
end


private

def set_category 
    @category = @user.categories.find(params[:category_id])
end

def task_params
    params.require(:task).permit(:name, :body, :due_date)
end

def set_task 
    @task = @category.tasks.find(params[:id])
end

def set_user
    @user = @current_user
end
end
