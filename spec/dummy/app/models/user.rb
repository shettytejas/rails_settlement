# frozen_string_literal: true

class User < ApplicationRecord
  def self.settable_params
    { params_key: :username, model_key: :username }
  end
end
