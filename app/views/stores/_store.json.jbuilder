json.id store.id
json.name store.name
json.store_address "#{store.address + ', ' +  store.try(:city) + ', ' +  store.try(:country)}"
json.created_at store.created_at.strftime("%d/%m/%Y %H:%M")
json.updated_at store.updated_at.strftime("%d/%m/%Y %H:%M")
json.url store_url(store, format: :json)
