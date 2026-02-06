# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class Datetime < Base

      def render?
        ransack? || ransack_range?
      end

      private

      def partial_name
        if ransack?
          "datetime"
        elsif ransack_range?
          "datetime_range"
        end
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => ::Time.now.to_s}, ransack_options)
      end

      def ransack_range?
        AdministrateRansack.ransack?(model, {"#{attribute}_gteq" => ::Time.now}, ransack_options) &&
          AdministrateRansack.ransack?(model, {"#{attribute}_lteq" => ::Time.now}, ransack_options)
      end
    end
  end
end
