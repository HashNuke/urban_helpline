class DataController < ApplicationController
  def calls
    "UrbanHelpline::#{Settings.telephone_provider.camelize}Provider".constantize
  end
end