# frozen_string_literal: true

ContentfulModel.configure do |config|
  config.access_token = Rails.application.credentials.contentful[:access_token]
  config.space = Rails.application.credentials.contentful[:space_id]
  config.environment = Rails.application.credentials.contentful[:environment_id]
  config.default_locale = 'en-US' # Optional - defaults to 'en-US'
  config.options = { # Optional
    # Extra options to send to the Contentful::Client and Contentful::Management::Client
    # See https://github.com/contentful/contentful.rb#configuration

    # Optional:
    # Use `delivery_api` and `management_api` keys to limit to what API the settings
    # will apply. Useful because Delivery API is usually visitor facing, while Management
    # is used in background tasks that can run much longer. For example:
    # delivery_api: {
    #   timeout_read: 6
    # },
    # management_api: {
    #   timeout_read: 100
    # }
  }
end
