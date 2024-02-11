# frozen_string_literal: true

class User < ApplicationRecord
  scope :active, -> { where(is_active: true) }

  def self.settable_params
    { params_key: :username, model_key: :username }
  end
end
