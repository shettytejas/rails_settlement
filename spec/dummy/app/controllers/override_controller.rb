# frozen_string_literal: true

class OverrideController < ApplicationController
  set_user model_key: :name, params_key: :user_name, only: %i[show]
  set_user! model_key: :name, params_key: :user_name, only: %i[edit]

  def show
    render plain: user ? user.name : "no user found"
  end

  def edit
    render plain: user.name
  end
end
