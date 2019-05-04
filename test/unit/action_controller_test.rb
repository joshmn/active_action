require 'test_helper'

describe ExampleController do
  let(:controller) { ExampleController.new }

  describe '#collection_actions' do
    it 'is an array' do
      assert controller.active_actions.is_a?(Array)
    end
  end

  describe 'helpers' do
    let(:helpers) { controller.helpers }

    it 'can access collection_actions_for' do
      assert helpers.active_actions_for
    end

    it 'returns collection_actions for scope' do
      assert_empty helpers.active_actions_for(:invalid_scope)
      refute_empty helpers.active_actions_for(:all)
      refute_empty helpers.active_actions_for(:all, :invalid_scope)
      assert_kind_of ActiveAction::Action, helpers.active_actions_for(:all)[0]
    end
  end

  describe 'collection_action defaults' do
    let(:action) { controller.active_actions[0] }

    it 'action is set correctly' do
      assert_equal :mark_as_read, action.action
    end

    it 'scopes is an array' do
      assert_kind_of Array, action.scopes
    end

    it 'has a default :all scope' do
      assert_includes action.scopes, :all
    end

    it 'only has one scope of :all' do
      assert_equal action.scopes, [:all]
    end

    it 'has a titleized label' do
      assert_equal "Mark As Read", action.label
    end

    it 'path is action' do
      assert_equal 'mark_as_read', action.path
    end
  end

  describe 'collection_action non-defaults' do
    let(:action) { controller.active_actions[1] }

    it 'label is Change to unread' do
      assert_equal "Change to unread", action.label
    end

    it 'scopes are :beer' do
      assert_equal action.scopes, [:beer]
    end

    it 'path is unread' do
      assert_equal 'unread', action.path
    end
  end
end