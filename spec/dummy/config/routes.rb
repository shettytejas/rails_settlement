# frozen_string_literal: true

Rails.application.routes.draw do
  resources :default, controller: :default, only: %i[edit show], param: :username
  resources :override, controller: :override, only: %i[edit show], param: :user_name
  resources :scoped, controller: :scoped, only: %i[edit show], param: :name
end
