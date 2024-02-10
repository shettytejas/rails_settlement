# Rails Settlement

A simple gem that helps you set objects before any action.

## Installation

Add to your Gemfile:
```ruby
gem 'rails_settlement'
```

## How to User

Let's suppose you want to fetch a `User` before performing a controller action:

```ruby
class UsersController < ApplicationController
  set_user only: %i[show] # Internally, it's just a before_action callback, so you can pass options to the callback directly.
  set_user! only: %i[edit] # Using this method with a bang (!) would trigger an ActiveRecord::RecordNotFound Exception.

  def show
    do_something with: user # You will also have an attribute reader with the same name available if the object is found. If not, it'll default to nil (unless a bang method is used, in which case an error is raised!)
  end
end
```

```ruby
class User < ApplicationRecord
  # This method would be used internally by set_user to fetch correct param (using params_key), and to send a key to #find_by (using model_key)
  # This can be also overridden on the fly by passing any of these two keys (or both!) in the controller directly
  # Ex: set_user params_key: :user_username, only: %i[index], ...
  def self.settable_params
    { params_key: :username, model_key: :username }
  end
end
```

This way you can use any model instead of a `User`. Just follow the naming convention `set_[model_name_in_snake_case]!`.

P.S: This should not work with STI or any Namespaced models. If you have a way to make them work, please raise a pull request!

That's about it!
