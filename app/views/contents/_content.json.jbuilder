json.extract! content, :id, :titolo, :descrizione, :prezzo, :created_at, :updated_at
json.url content_url(content, format: :json)
