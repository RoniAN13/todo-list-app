class TodoList < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  has_many :todo_items,dependent: :destroy
  
  def done_items(list)
    if list.todo_items.where(status_flag:true)
    list.todo_items.where(status_flag:true).count
    else 
      0.to_f
    end  
  end
  def percentage(a,b)
   
     if b.to_f > 0
     result = (a.to_f/b.to_f)*100
     else 
      result = 0.0
     end

  end
   
end
