# ActiveAction

An elegant DSL to define batch actions in your Rails controllers and display them in your views.

## Idea

The idea of ActiveAction is to use a form object to submit the form, but changing the action you submit to — as chosen by the user in your batch actions selection.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_action'
```

And then execute:

    $ bundle

And restart your Rails server.

## Usage

Use the `active_action :route, options = {}` DSL to define a batch action.

Then build your batch action dropdown with `active_actions.each { ... }` in your view.

## Step-by-step

### Controller

Define your actions.

    class NotificationsController < ApplicationController  
      active_action :mark_as_read, label: "Mark selected as read"
      
      def mark_as_read
        notifications = Notification.find(params[:collection_ids])
        notifications.update_all(read: true)
        redirect_to notifications_path, notice: "Marked as read"
      end
    end
 
### View
    
Wrap your ActiveRecord collection (or whatever collection) into a form object. Then, drop in a button to handle the batch actions you defined in your controller.

```erbruby
<%= simple_form_for :notifications do |f| %>
    <div class="dropdown">
      <a class="btn btn-secondary dropdown-toggle active_actions_button" disabled="disabled" href="#" id="activeActionsButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Actions</a>
      <div class="dropdown-menu" aria-labelled-by="activeActionsButton">
        <% active_actions_for(:all).each do |action| %>
          <a class="dropdown-item active_action" href="javascript:;" data-action="<%= action.path %>"><%= action.label %></a>
        <% end %>
      </div>
    </div>
    <table>
        <thead>
            <tr>
                <td></td>
                <td>Content</td>
            </tr>
        </thead>
        <tbody>
            <% @notifications.each do |notification| %>
                <tr>
                    <td><input type="checkbox" name="collection_ids[]" value=<%= notification.id %>" /></td>
                    <td><%= notification.content %></td>
                </tr>
            <% end %>
        </tbody>
    </table>
<% end %>
```    

### And some Javascript

Lastly, drop in some Javascript to handle changing the form action.

```javascript
$('.active_action').on('click', function() {
    var form = $(this).closest('form');
    form.attr('action', form.attr('action') + "/" + $(this).attr('data-action'));
    form.submit();
});
```
    
## Frequently asked questions

### I want to submit to a member route. What does my view look like?

Just change what the form submits to. More info with examples here.

```erbruby
<%= simple_form_for @restaurant do |f| %>
    <%= active_actions_button_for(:beers) %>
    <table>
        <thead>
            <tr>
                <td></td>
                <td>Beer name</td>
            </tr>
        </thead>
        <tbody>
            <% @resetaurant.beers.each do |beer| %>
                <tr>
                    <td><input type="checkbox" name="collection_ids[]" value=<%= beer.id %>" /></td>
                    <td><%= beer.name %></td>
                </tr>
            <% end %>
        </tbody>
    </table>
<% end %>
```

## Frequently asked questions

### Does this come with javascript to handle select-all-ish functionality? 

Nope. [But you can use what I've been using for my projects](https://github.com/joshmn/active_action/wiki/Drop-in-javascript-for-your-tables).

### What's a scope?

A scope merely defines what context a active action is relevant to inside its controller. Say you had `RestaurantsController` and you wanted to "Mark as visited" (for `:restaurants`), or for their beers selection (presumably on your `restaurants#show` view), "Mark [beer] as consumed" for `:beers`. You could define these as separate scopes for your active actions array. 

Defaults to `:all`.

### Why don't you just d—

Because I loathe javascript.