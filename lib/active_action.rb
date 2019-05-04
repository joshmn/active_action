require 'action_controller'
require 'rails/railtie'
require 'active_action/action_controller'
require 'active_action/renderer'
require 'active_action/bootstrap_dropdown'
require 'active_action/action'
require 'active_action/view_helpers'

module ActiveAction
  class Engine < Rails::Railtie
    initializer 'activeaction.controller' do
      ActiveSupport.on_load(:action_controller) do
        ::ActionController::Base.send(:include, ActiveAction::ActionController)
      end
    end
  end
end
