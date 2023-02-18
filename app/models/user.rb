class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :transaction_items, foreign_key: 'author_id', dependent: :destroy
  has_many :categories, foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
