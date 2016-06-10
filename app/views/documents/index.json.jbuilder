json.array!(@documents) do |document|
  json.extract! document, :id, :text
  json.url document_url(document, format: :json)
end
