json.array!(@duties) do |duty|
  json.extract! duty, :id, :discipline_id, :student_id, :document_id, :name
  json.url duty_url(duty, format: :json)
end
