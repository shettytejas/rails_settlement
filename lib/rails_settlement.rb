# frozen_string_literal: true

require "rails_settlement/version"

require "active_support"
require "active_support/concern"

module RailsSettlement
  extend ActiveSupport::Concern

  SETTABLE_REGEX = /\Aset_(?<object>[a-z_]+)(?<raisable>!?)\z/.freeze

  class_methods do
    def method_missing(method, **options)
      super unless (matches = method.to_s.match(SETTABLE_REGEX))

      variable, raisable = _handle_match_data(matches)
      klass = _klass(variable)
      param_options = _param_options(klass: klass, options: options)

      before_action(**options) do
        klass = _handle_scopes(klass, param_options[:scope_to])
        instance_variable_set("@#{variable}", klass.find_by(param_options[:model_key] => params[param_options[:params_key]]))
        raise ActiveRecord::RecordNotFound if raisable && instance_variable_get("@#{variable}").nil?
      end

      attr_reader variable
    end

    def respond_to_missing?(method, include_private = false)
      super || method.to_s.match?(SETTABLE_REGEX)
    end

    private

    def _handle_match_data(match_data)
      [match_data[:object], match_data[:raisable].present?]
    end

    def _klass(variable)
      variable.classify.constantize
    end

    def _param_options(klass:, options:)
      (klass.try(:settable_params) || {}).merge(options.extract!(:model_key, :params_key, :scope_to))
    end
  end

  def _handle_scopes(klass, scopes)
    return klass if scopes.blank?

    scopes = [scopes] unless scopes.is_a?(Array)
    scopes.each { |scope| klass = klass.public_send(scope) }

    klass
  end
end

ActiveSupport.on_load(:action_controller) do
  include RailsSettlement
end
