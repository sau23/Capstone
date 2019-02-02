json.extract! user, :id, :user_id, :gender, :age, :department, :clinical_year, :created_at, :updated_at
json.url user_url(user, format: :json)
