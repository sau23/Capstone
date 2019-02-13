class Question < ApplicationRecord
    validates :question_id, :to_ask, :option_1, :option_2, :option_3, :option_4, presence: true
    validates :question_id, numericality: { greater_than: -1 }
end
