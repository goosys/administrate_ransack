# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class BelongsTo < Base

      def render?
        association? && ( ransack? || ransack_eq? )
      end

      private

      def partial_name
        "belongs_to"
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => "1,2"}, ransack_options)
      end

      def ransack_eq?
        AdministrateRansack.ransack?(model, {"#{attribute}_id_eq" => "1,2"}, ransack_options)
      end

      # Partial Strict Locals
      #   <%# locals: { form: , model: , field: , label: , type: , label_attr: , input_attr: , options: , collection: } %>
      def locals
        super.merge({
          collection: collection
        })
      end

      def label_attr
        label || (ransack? ? attribute : "#{attribute}_id")
      end

      def input_attr
        ransack? ? attribute : "#{attribute}_id_eq"
      end

      def association?
        model.reflections[attribute.to_s].present?
      end

      def collection
        resource_field = type.new(attribute, nil, Administrate::Page::Collection.new(model), resource: model.new)
        resource_field.associated_resource_options
      end
    end
  end
end
