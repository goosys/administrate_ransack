# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class Number < Base

      def render?
        ransack? || ransack_range?
      end

      private

      def partial_name
        if ransack?
          "number"
        elsif ransack_range?
          "number_range"
        end
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => "1"}, ransack_options)
      end

      def ransack_range?
        AdministrateRansack.ransack?(model, {"#{attribute}_gteq" => "1"}, ransack_options) &&
          AdministrateRansack.ransack?(model, {"#{attribute}_lteq" => "1"}, ransack_options)
      end

    end
  end
end
