# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class Date < Base

      def render?
        ransack? || ransack_range?
      end

      private

      def partial_name
        if ransack?
          "date"
        elsif ransack_range?
          "date_range"
        end
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => ::Date.today}, ransack_options)
      end

      def ransack_range?
        AdministrateRansack.ransack?(model, {"#{attribute}_gteq" => ::Date.today}, ransack_options) &&
          AdministrateRansack.ransack?(model, {"#{attribute}_lteq_end_of_day" => ::Date.today}, ransack_options)
      end

    end
  end
end
