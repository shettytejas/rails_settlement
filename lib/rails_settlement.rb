# frozen_string_literal: true

require "rails_settlement/version"

require "active_support"
require "active_support/concern"

module RailsSettlement
  extend ActiveSupport::Concern

  SETTABLE_REGEX = /\Aset_(?<object>[a-z_]+)(?<raisable>!?)\z/.freeze

  class_methods do
    def method_missing(method, **options)
      super unless (match_data = method.to_s.match(SETTABLE_REGEX))

      variable = match_data[:object]
      raisable = match_data[:raisable].present?

      klass = variable.classify.constantize

      param_options = (klass.try(:settable_params) || {}).merge(options.extract!(:model_key, :params_key))

      before_action(**options) do
        instance_variable_set("@#{variable}", klass.find_by(param_options[:model_key] => params[param_options[:params_key]]))
        raise ActiveRecord::RecordNotFound if raisable && instance_variable_get("@#{variable}").nil?
      end

      attr_reader variable
    end

    def respond_to_missing?(method, include_private = false)
      super || method.to_s.match?(SETTABLE_REGEX)
    end
  end
end

ActiveSupport.on_load(:action_controller_base) do
  include RailsSettlement
end
