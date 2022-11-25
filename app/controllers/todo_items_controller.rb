class TodoItemsController < ApplicationController
    before_action :set_todo_list
    
    
    def create
        
        @todo_item = current_user.todo_items.new(todo_item_params)
      
        if @todo_item.save
                update_todo_list
                render turbo_stream: turbo_stream.update(@todo_list, partial: "todo_lists/todo_list_info",locals:{todo_list:@todo_list}) 
        
        else
            render turbo_stream: turbo_stream.replace(@todo_item, partial: "todo_items/form",locals:{todo_list:@todo_list}) 
        end  
       
    end
    def update
        
        @todo_item = @todo_list.todo_items.find(params[:id])
        if @todo_item.status_flag == false
            @todo_item.update(status_flag: true)
        
        else
            @todo_item.update(status_flag: false)
        end
        update_todo_list
        render turbo_stream: turbo_stream.update(@todo_list, partial: "todo_lists/todo_list_info",locals:{todo_list:@todo_list}) 
    end    
    def destroy
        @todo_item = @todo_list.todo_items.find(params[:id])
        @todo_item.destroy
        update_todo_list
        render turbo_stream: turbo_stream.update(@todo_list, partial: "todo_lists/todo_list_info",locals:{todo_list:@todo_list}) 
    end    
  private 
    def todo_item_params
        params.require(:todo_item).permit(:task).merge(todo_list_id: params[:todo_list_id])
    end
    def set_todo_list
        @todo_list= TodoList.find(params[:todo_list_id])
    end
    def update_todo_list
        @todo_items = @todo_list.todo_items.all
        @todo_list.update(status:"Not Started") if @todo_items.count == 0
        if @todo_items.count!=0 && @todo_list.done_items(@todo_list) == @todo_items.count  
            @todo_list.update(status:"Completed")
        elsif @todo_list.done_items(@todo_list) < @todo_items.count
            unless @todo_list.done_items(@todo_list) ==0
                @todo_list.update(status:"In Progress")
            else 
                @todo_list.update(status:"Not Started")

            end
        end        
    end    
end
