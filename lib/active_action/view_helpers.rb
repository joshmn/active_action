module ActiveAction
  module ViewHelpers
    NO_ACTIVE_ACTIONS_MESSAGE = "<!-- No active actions found. -->"
    DEFAULT_LABEL = "Active actions"

    def active_selection_tag(value, checked = false, options = {})
      check_box_tag 'collection_ids[]', value, checked, {class: 'active_actions_selection'}.merge(options)
    end

    def active_actions_button(label)
      active_actions_button_for(:all, label: label)
    end

    def active_actions_button_for(scopes = [:all], label: DEFAULT_LABEL, renderer: BootstrapDropdown)
      actions = active_actions_for(scopes)
      if actions.empty?
        return NO_ACTIVE_ACTIONS_MESSAGE.html_safe
      end
      renderer.to_html(label: label, actions: actions)
    end
  end
end