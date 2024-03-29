module UrbanHelpline
  class ExotelProvider

    def self.handle_call_data_webhook(params)
      unless ["free", "busy"].include?(params["Status"]) || params["CallType"] == "completed"
        return
      end

      status = params["Status"] || params["CallType"]
      self.send("parse_#{status}_webhook", params)
    end

    private

    def self.parse_completed_webhook(params)
      provider_call_id = params["CallSid"]
      phone_call = PhoneCall.find_by(provider_call_id: provider_call_id) rescue false
      if phone_call
        phone_call.update_attributes(duration: params["DialCallDuration"], status: "completed")
      end
    end

    def self.parse_busy_webhook(params)
      #NOTE yet to implement
    end

    def self.parse_free_webhook(params)
      PhoneCall.create(
        operator_email: params["AgentEmail"],
        operator_phone: params["DialWhomNumber"],
        phone: params["CallFrom"],
        provider_call_id: params["CallSid"],
        status: "attended"
      )
    end

  end
end
