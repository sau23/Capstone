class Optional < ApplicationRecord
    validates :response, length: { maximum: 1000 }
end
