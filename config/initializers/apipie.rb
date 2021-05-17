Apipie.configure do |config|
  config.app_name                = "Product Storage"
  config.api_base_url            = nil
  config.doc_base_url            = "/documentation"
  config.translate = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
