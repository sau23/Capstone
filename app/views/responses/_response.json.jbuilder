json.extract! response, :id, :survey_id, :question_id, :user_id, :response, :response_text, :created_at, :updated_at
json.url response_url(response, format: :json)
