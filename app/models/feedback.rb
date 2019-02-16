class Feedback < ApplicationRecord
   validates :experience, :future, :difficulty, presence: true
end
