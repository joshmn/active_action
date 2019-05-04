ENV["RAILS_ENV"] = "test"

require "active_support"
require "action_controller"
require "rails/railtie"

ActionController::Base.view_paths = File.join(File.dirname(__FILE__), 'views')