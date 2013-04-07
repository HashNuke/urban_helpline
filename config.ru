# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'faye'
require ::File.expand_path("../lib/active_users.rb",  __FILE__)
require ::File.expand_path("../lib/faye_extensions/devise_auth.rb",  __FILE__)

Faye::WebSocket.load_adapter('thin')

faye_server = Faye::RackAdapter.new(:mount => "/faye", :timeout => 30)
faye_server.add_extension(DeviseAuth.new)

FAYE_CLIENT = faye_server.get_client

faye_server.bind(:unsubscribe) do |client_id|
  ActiveUsers.remove_by_client_id(client_id)
end

#run Rails.application

run Rack::URLMap.new({
    "/remote" => faye_server,
    "/"       => UrbanHelpline::Application
  })


