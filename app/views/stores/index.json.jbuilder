json.stores do
  json.array! @stores, partial: "stores/store", as: :store
end