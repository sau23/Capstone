class Question < ApplicationRecord
    validates :to_ask, :option_1, :option_2, :option_3, presence: true
    validates :question_id, numericality: { greater_than: -1 }
end
