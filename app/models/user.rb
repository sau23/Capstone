class User < ApplicationRecord
    validates :user_id, :gender, :department, :role, :years_worked, presence: true
    validates :age, numericality: { greater_than: 19, less_than: 100 }
end
