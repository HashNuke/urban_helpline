class DataController < ApplicationController
  def calls
    provider_klass = "UrbanHelpline::#{Settings.telephone_provider.camelize}Provider".constantize
    provider_klass.handle_call_data_webhook(params)
  end
end