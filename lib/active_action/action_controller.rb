module ActiveAction
  module ActionController
    extend ActiveSupport::Concern

    included do
      extend ClassMethods
      include InstanceMethods
      helper HelperMethods
      helper_method :active_actions
    end

    module ClassMethods
      # Rails generates CSRF tokens on a per-form basis.
      # This means things will break when you change the action.
      #
      # See https://github.com/rails/rails/pull/22275 for more info.
      def active_action(action_name, options = {})
        protect_from_forgery except: action_name
        add_active_action(action_name, options)
      end

      def add_active_action(action_name, options = {})
        options = normalize_active_action_options(action_name, options)
        _active_actions << ActiveAction::Action.new(action_name, options)
      end

      def normalize_active_action_options(action_name, options)
        options[:label] ||= action_name.to_s.titleize
        options[:scopes] ||= []
        options[:scopes] += (Array.wrap(options[:scope]))
        if options[:scopes].empty?
          options[:scopes] << :all
        end
        options[:scopes].map!(&:to_sym)
        options[:path] ||= action_name
        options
      end

      def _active_actions
        @_active_actions ||= []
      end
    end

    module InstanceMethods
      def active_actions
        self.class._active_actions
      end
    end

    module HelperMethods
      # Finds collection_actions for the specified `scopes`
      def active_actions_for(*scopes)
        scopes = Array.wrap(scopes.presence || :all)
        active_actions.select do |ca|
          (scopes & ca.scopes).any?
        end
      end
    end
  end
end