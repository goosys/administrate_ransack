# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class HasMany < Base

      def render?
        association? && (ransack? || ransack_in?)
      end

      private

      def partial_name
        if field_type == :select
          "has_many_select"
        else
          "has_many_checkbox"
        end
      end

      def locals
        super.merge({
          collection: collection
        })
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => "1,2"}, ransack_options)
      end

      def ransack_in?
        AdministrateRansack.ransack?(model, {"#{attribute}_id_in" => "1,2"}, ransack_options)
      end

      def label_attr
        label || input_attr
      end

      def input_attr
        ransack? ? attribute : "#{attribute}_id_in"
      end

      def association?
        model.reflections[attribute.to_s].present?
      end

      def collection
        resource_field = type.new(attribute, nil, Administrate::Page::Collection.new(model), resource: model.new)
        resource_field.associated_resource_options
      end

      def field_type
        resource_field = type.new(attribute, nil, Administrate::Page::Collection.new(model), resource: model.new)
        field_type = resource_field.options&.dig(:field_type)
        field_type ||= field_options&.dig(:field_type)
        field_type ||= AdministrateRansack.options&.dig(:has_many_field_type_default)
        field_type = field_type.to_sym.eql?(:select) ? :select : :checkbox
      end
    end
  end
end
