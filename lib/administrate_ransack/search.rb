# frozen_string_literal: true

require 'ransack'

module AdministrateRansack
  class Search
    attr_reader :ransack_results

    def initialize(scoped_resource, dashboard, term, options: {})
      @dashboard = dashboard
      @scoped_resource = scoped_resource
      @term = term
      @ransack_options = options.delete(:ransack_options) { {} }
      @distinct = options.delete(:distinct) { true }
    end

    def run
      if @term.blank?
        @ransack_results = @scoped_resource.ransack({}, **@ransack_options)
        ransack_result(@scoped_resource)
      else
        ransack_result(@scoped_resource)
      end
    end

    private

    def ransack_result(scoped_resource)
      @ransack_results = prepare_search(scoped_resource:)
      prepare_result(@ransack_results)
    end

    def prepare_search(scoped_resource:)
      scoped_resource.ransack(@term, **@ransack_options)
    rescue ArgumentError => e
      if defined?(Ransack::InvalidSearchError) && e.is_a?(Ransack::InvalidSearchError) # rubocop:disable Style/GuardClause
        ransack_invalid_search_error(e)
        scoped_resource.ransack({}, **@ransack_options)
      else
        raise e
      end
    end

    def prepare_result(ransack_results)
      ransack_results.result(distinct: @distinct)
    end
  end
end
