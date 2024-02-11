# Rails Settlement

A simple gem that helps you set objects before any action.

## Installation

Add to your Gemfile:
```ruby
gem 'rails_settlement'
```

## How to Use

Suppose you need to fetch a User before executing a controller action:

```ruby
class UsersController < ApplicationController
  set_user only: %i[show] # It's essentially a before_action callback, allowing you to pass options directly.

  # Using the bang (!) with this method triggers an ActiveRecord::RecordNotFound Exception.
  set_user! only: %i[edit]

  # You can also define a scope with the `scope_to` option. It can be either a string/symbol or an Array of string/symbols.
  # This fetches the user after chaining all the scopes together.
  # set_user scope_to: :is_active, only: %i[show] #=> User.is_active.find_by
  # set_user! scope_to: %i[is_active is_admin] #=> User.is_active.is_admin.find_by

  def show
    do_something with: user # You also have an attribute reader with the same name available if the object is found. If not, it defaults to nil (unless a bang method is used, in which case an error is raised!)
  end
end
```

```ruby
class User < ApplicationRecord
  scope :is_active, -> { where(is_active: true) }

  # This method is used internally by `set_user` to fetch the correct param (using `params_key`) and to send a key to `find_by` (using `model_key`).
  # You can override this on the fly by passing any of these two keys (or both!) in the controller directly.
  # Ex: set_user params_key: :user_username, only: %i[index], ...
  # You can also pass a `scope_to` option in the hash below.
  def self.settable_params
    { params_key: :username, model_key: :username }
  end
end
```

This approach allows you to use any model instead of a `User`. Just follow the naming convention set_[model_name_in_snake_case]!.

Note: This implementation does not support STI or any Namespaced models. If you have a solution to make them work, please submit a pull request!

That's about it!
