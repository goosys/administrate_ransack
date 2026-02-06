# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class Boolean < Base

      def render?
        ransack? || ransack_eq?
      end

      private

      def partial_name
        "boolean_select"
      end

      # Partial Strict Locals
      #   <%# locals: { form: , model: , field: , label: , type: , label_attr: , input_attr: , options: , collection: } %>
      def locals
        super.merge({
          collection: collection
        })
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => "true"}, ransack_options)
      end

      def ransack_eq?
        AdministrateRansack.ransack?(model, {"#{attribute}_present" => "true"}, ransack_options)
      end

      def input_attr
        if ransack?
          attribute
        elsif ransack_eq?
          "#{attribute}_present"
        end
      end

      def collection
        [
          [I18n.t(collection_i18n_key(:yes), default: collection_i18n_defaults(:yes), scope: collection_i18n_scope), "true"],
          [I18n.t(collection_i18n_key(:no), default: collection_i18n_defaults(:no), scope: collection_i18n_scope), "false"]
        ]
      end

      def collection_i18n_key(key)
        :"boolean.#{model.model_name.i18n_key}.#{attribute}.#{key}"
      end

      def collection_i18n_defaults(key)
        [
          :"#{key}",
        ]
      end

      def collection_i18n_scope
        :'administrate_ransack.filters'
      end

    end
  end
end
