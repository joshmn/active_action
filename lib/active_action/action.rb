module ActiveAction
  class Action
    attr_reader :action, :label, :scopes, :path
    def initialize(action, options = {})
      options.assert_valid_keys(:scope, :label, :path, :scopes)
      @action = action
      @label = options[:label] || @action.to_s
      @scopes = options[:scopes] || Array.wrap(options[:scope] || :all)
      @path = (options[:path] || @action).to_s
    end
  end
end