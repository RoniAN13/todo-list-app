class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?
  def index
    @todo_lists= current_user.todo_lists.all
  end

  def new
    @todo_list= TodoList.new
  end
  def edit
    @todo_list = TodoList.find(params[:id])
  end  
  def update
    @todo_list = TodoList.find(params[:id])
    
    if @todo_list.update(todo_list_params)
      flash[:success] = 'List updated'
      redirect_to todo_lists_path
    
    else
      render 'edit'
    end

  end

  def show
    @todo_list = TodoList.find(params[:id])
    @todo_items = @todo_list.todo_items.all
  end
  def create
    @todo_list = current_user.todo_lists.build(todo_list_params)
    if @todo_list.save
      flash[:notice]= "List created successfully"
      redirect_to todo_lists_path
    else
      flash.now[:alert] = "Title Required"
      render 'new'
    end
  end
  def destroy 
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    flash[:alert]="List Deleted"
    redirect_to todo_lists_path
  end
  private
  
  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
