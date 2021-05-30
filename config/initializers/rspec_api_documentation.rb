RspecApiDocumentation.configure do |config|
  # Set the application that Rack::Test uses
  config.app = Rails.application

  # Output folder
  config.docs_dir = Rails.root.join("doc", "api")

  config.format = :json
end