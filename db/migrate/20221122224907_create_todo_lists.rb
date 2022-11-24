class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :title,null:false
      t.string :status,null:false,default: "Not Started"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
