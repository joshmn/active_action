module ActiveAction
  class BootstrapDropdown < Renderer
    def self.to_html(label:, actions:)
      new(label: label, actions: actions).to_html
    end

    attr_reader :label, :actions
    def initialize(label:, actions:)
      @label = label
      @actions = actions
    end

    def to_html
      capture do
        content_tag(:div, class: "dropdown") do
          concat dropdown_tag(label)
          concat dropdown_for(actions)
        end
      end
    end

    private

    def dropdown_tag(label)
      content_tag(:a, class: "btn btn-secondary dropdown-toggle active_actions_button", disabled: :disabled, href: "#", id: "activeActionsButton", data: { toggle: "dropdown" }, aria: { haspopup: 'true', expanded: 'false' }) do
        label
      end
    end

    def dropdown_for(actions)
      content_tag(:div, class: "dropdown-menu", 'aria-labelled-by': "activeActionsButton") do
        actions.each do |act|
          concat content_tag(:a, class: "dropdown-item active_action", href: "javascript:;", data: { action: act.path }) { act.label }
        end
      end
    end
  end
end