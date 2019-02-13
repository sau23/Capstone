class User < ApplicationRecord
    validates :user_id, :gender, :department, :clinical_year, presence: true
    validates :age, numericality: { greater_than: 19, less_than: 100 }
end
