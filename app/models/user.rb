class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :todo_lists,dependent: :destroy
  has_many :todo_items,dependent: :destroy
  after_create_commit { broadcast_append_to "users" }
end