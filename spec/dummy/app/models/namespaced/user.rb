# frozen_string_literal: true

class Namespaced::User < Namespaced # rubocop:disable Style/ClassAndModuleChildren
  scope :is_admin, -> { where(is_admin: true) }

  def self.settable_params
    { params_key: :name, model_key: :name }
  end
end
