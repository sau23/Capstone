json.extract! response, :id, :is_gamified, :question_id, :user_id, :selection, :response_text, :created_at, :updated_at
json.url response_url(response, format: :json)
