class TodoItem < ApplicationRecord
  belongs_to :todo_list
  belongs_to :user
  validates :task,presence:true
  after_create_commit { broadcast_append_to self.todo_list}
  after_update_commit { broadcast_replace_to self.todo_list}
  after_destroy_commit { broadcast_remove_to self.todo_list}
end
