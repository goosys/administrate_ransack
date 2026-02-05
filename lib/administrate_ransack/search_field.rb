# frozen_string_literal: true

require 'ransack'

module AdministrateRansack
  class SearchField
    attr_reader :attribute, :type, :label
    attr_reader :input_type, :component, :field_options

    def initialize(attribute, type, label, model, f, ransack_options, field_options = {})
      @attribute = attribute
      @type = type
      @label = label
      @model = model
      @f = f
      @ransack_options = ransack_options
      @field_options = field_options
    end

    def prepare
      @input_type = @type.is_a?(Administrate::Field::Deferred) ? @type.deferred_class.to_s : @type.to_s
      @component = AdministrateRansack.filters[input_type] || 'field_other'
      @field_options = @field_options.is_a?(Hash) ? (@field_options[@attribute.to_s] || {}) : {}
      self
    end

    def render_in(view_context)
      view_context.render(
        partial: "administrate_ransack/components/#{@component}",
        locals: {
          form: @f,
          model: @model,
          field: @attribute,
          label: @label,
          type: @type,
          ransack: ransack?,
          ransack_cont: ransack_cont?,
          options: @field_options
        }
      )
    end

    private

    def render?
      true
    end

    def ransack?
      case @component
      when 'field_string', 'field_other'
        AdministrateRansack.ransack?(@model, {attribute => "valid"}, @ransack_options)
      when 'field_number'
        AdministrateRansack.ransack?(@model, {attribute => "1"}, @ransack_options)
      when 'field_date_time'
        AdministrateRansack.ransack?(@model, {attribute => Time.now}, @ransack_options)
      when 'field_date'
        AdministrateRansack.ransack?(@model, {attribute => Date.today}, @ransack_options)
      when 'field_belongs_to', 'field_has_many'
        AdministrateRansack.ransack?(@model, {attribute => "1,2"}, @ransack_options)
      when 'field_boolean'
        AdministrateRansack.ransack?(@model, {attribute => "true"}, @ransack_options)
      else
        false
      end
    end

    def ransack_cont?
      case @component
      when 'field_string', 'field_other'
        AdministrateRansack.ransack?(@model, {"#{attribute}_cont" => "valid"}, @ransack_options)
      else
        false
      end
    end
  end
end
