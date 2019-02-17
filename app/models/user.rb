class User < ApplicationRecord
    validates :user_id, :gender, :department, :is_surgical_specialist, :role, :years_worked, presence: true
    validates :age, numericality: { greater_than: 19, less_than: 100 }
end
