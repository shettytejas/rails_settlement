# frozen_string_literal: true

class NamespacedController < ActionController::API
  set_user scope_to: :is_admin, namespace: :namespaced, only: %i[show]
  set_user! scope_to: [:is_admin], namespace: "namespaced", only: %i[edit]

  def show
    render plain: user.username
  end

  def edit
    render plain: user.username
  end
end
