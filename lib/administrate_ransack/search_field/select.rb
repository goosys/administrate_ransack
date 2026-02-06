# frozen_string_literal: true

module AdministrateRansack
  module SearchField
    class Select < Base

      def render?
        ransack?
      end

      private

      def partial_name
        if options[:select]&.to_sym == :radio
          "select_radio"
        else
          "select"
        end
      end

      def ransack?
        AdministrateRansack.ransack?(model, {attribute => "valid"}, ransack_options)
      end

      def locals
        super.merge({
          collection: collection
        })
      end

      def collection
        options[:collection] || []
      end
    end
  end
end
