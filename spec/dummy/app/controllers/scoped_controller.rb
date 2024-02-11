# frozen_string_literal: true

class ScopedController < ActionController::API
  set_user model_key: :name, params_key: :name, scope_to: :active, only: %i[show]
  set_user! model_key: :name, params_key: :name, scope_to: [:active], only: %i[edit]

  def show
    render plain: user.username
  end

  def edit
    render plain: user.username
  end
end
