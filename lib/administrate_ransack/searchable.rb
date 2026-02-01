# frozen_string_literal: true

require 'ransack'

module AdministrateRansack
  module Searchable
    private def filter_resources(resources, search_term:)
      @ransack_filter = 
        AdministrateRansack::Search.new(
          resources,
          dashboard,
          params[:q],
          options: {
            ransack_options: respond_to?(:ransack_options, true) ? ransack_options : {},
            distinct: respond_to?(:ransack_result_distinct, true) ? ransack_result_distinct : true
          }
        )
      @ransack_filter.run.tap do |result|
        @ransack_results = @ransack_filter.ransack_results
      end
    end

    # ref => https://github.com/thoughtbot/administrate/blob/v0.18.0/app/helpers/administrate/application_helper.rb#L72-L78
    def sanitized_order_params(page, current_field_name)
      collection_names = page.item_associations + [current_field_name]
      association_params = collection_names.map do |assoc_name|
        { assoc_name => %i[order direction page per_page] }
      end
      params.permit(:search, :id, :_page, :per_page, association_params, q: {})
    end

    def ransack_search_field_permitted?(form: nil, model: nil, field: nil, label: nil, type: nil, input_type: nil, options: {})
      if defined?(super)
        super
      else
        return if field == :id
        true
      end
    end

    def ransack_options
      if defined?(super)
        super
      else
        {}
      end
    end

    class << self
      def prepended(base)
        base.helper_method :sanitized_order_params
        base.helper_method :ransack_search_field_permitted?
        base.helper_method :ransack_options
      end
    end

  end
end
