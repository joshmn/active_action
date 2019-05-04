require 'minitest/autorun'
require 'dummy'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'active_action'


class ExampleController < ActionController::Base
  include ActiveAction::ActionController

  active_action :mark_as_read
  active_action :mark_as_unread, label: "Change to unread", scopes: [:beer], path: "unread"
end
