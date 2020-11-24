class TasksController < ApplicationController
  def index
    @tasks = Task.all.page(params[:page])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正しく追加されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが追加されませんでした。'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Taskが正しく更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが更新されませんでした。'
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskは正しく削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
