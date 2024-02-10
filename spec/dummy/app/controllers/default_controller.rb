# frozen_string_literal: true

class DefaultController < ActionController::Base
  set_user only: %i[show]
  set_user! only: %i[edit]

  def show
    render plain: user.name
  end

  def edit
    render plain: user.name
  end
end
