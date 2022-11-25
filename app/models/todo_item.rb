class TodoItem < ApplicationRecord
  belongs_to :todo_list
  belongs_to :user
  validates :task,presence:true
  after_create_commit { broadcast_append_to "todo_items"}
  after_update_commit { broadcast_replace_to "todo_items"}
  after_destroy_commit { broadcast_remove_to "todo_items"}
end
