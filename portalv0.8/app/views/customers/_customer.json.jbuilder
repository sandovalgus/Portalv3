json.extract! customer, :id, :n_socio, :nombre, :apellido, :created_at, :updated_at
json.url customer_url(customer, format: :json)
