# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class Base
      attr_reader :attribute, :type, :label
      attr_reader :model, :f, :ransack_options
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
        @field_options = @field_options.is_a?(Hash) ? (@field_options[@attribute.to_s] || {}) : {}
        self
      end

      def render_in(view_context)
        view_context.render(
          partial: partial_path,
          layout: layout_path.presence || nil,
          locals: locals
        )
      end

      def render?
        false
      end

      private

      def partial_path
        "#{partial_prefix}#{partial_name}"
      end

      def partial_name
        "field_base"
      end

      def partial_prefix
        "administrate_ransack/components/"
      end

      def layout_path
        "administrate_ransack/components/default_layout"
      end

      # Partial Strict Locals
      #   <%# locals: { form: , model: , field: , label: , type: , label_attr: , input_attr: , options: } %>
      def locals
         {
          form: f,
          model: model,
          field: attribute,
          label: label,
          type: type,
          label_attr: label_attr,
          input_attr: input_attr,
          options: field_options
        }
      end

      # def ransack?
      #   case @component
      #   when 'field_string', 'field_other'
      #     AdministrateRansack.ransack?(model, {attribute => "valid"}, ransack_options)
      #   when 'field_number'
      #     AdministrateRansack.ransack?(model, {attribute => "1"}, ransack_options)
      #   when 'field_date_time'
      #     AdministrateRansack.ransack?(model, {attribute => Time.now}, ransack_options)
      #   when 'field_date'
      #     AdministrateRansack.ransack?(model, {attribute => Date.today}, ransack_options)
      #   when 'field_belongs_to', 'field_has_many'
      #     AdministrateRansack.ransack?(model, {attribute => "1,2"}, ransack_options)
      #   when 'field_boolean'
      #     AdministrateRansack.ransack?(model, {attribute => "true"}, ransack_options)
      #   else
      #     false
      #   end
      # end

      # # TODO
      # def permitted_attributes
      #   []
      # end

      def label_attr
        label || attribute
      end

      def input_attr
        attribute
      end

    end
  end
end
