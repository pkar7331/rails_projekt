json.extract! ticket, :id, :amount, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
