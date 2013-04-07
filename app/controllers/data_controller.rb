class DataController < ApplicationController
  def calls
    provider_klass = "UrbanHelpline::#{Settings.telephone_provider.camelize}Provider".constantize
    provider_klass.handle_call_data_webhook(params)

    render nothing: true
  end

  def operators
    phone_numbers = User.where(call_handler_status: "available").pluck(:phone)
    render text: phone_numbers.join(",")
  end
end