class Response < ApplicationRecord
    validates :selection, presence: true
    validates :response_text, length: { maximum: 500 }
end
