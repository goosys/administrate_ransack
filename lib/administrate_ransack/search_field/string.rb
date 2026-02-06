# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class String < Base

      def render?
        ransack? || ransack_cont?
      end

      private

      def partial_name
        "string"
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => "valid"}, ransack_options)
      end

      def ransack_cont?
        AdministrateRansack.ransack?(model, {"#{attribute}_cont" => "valid"}, ransack_options)
      end

      def label_attr
        if ransack?
          super
        elsif ransack_cont?
          @label || "#{attribute}_cont"
        end
      end

      def input_attr
        if ransack?
          super
        elsif ransack_cont?
          "#{attribute}_cont"
        end
      end

    end
  end
end
