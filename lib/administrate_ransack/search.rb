# frozen_string_literal: true

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

    def search_fields(attribute_types: {}, attribute_labels: {}, f: nil)
      attribute_types = attribute_types.presence || default_search_attributes
      attribute_types.map do |attribute, type|
        label = attribute_labels[attribute]
        search_field_class = search_field_class_by(type)
        if search_field_class.blank?
          Rails.logger.warn "No search field class for type: #{type} (attribute: #{attribute})"
          next
        elsif search_field_class.respond_to?(:new).blank?
          pp search_field_class
          Rails.logger.warn "Invalid search field class for type: #{type} (attribute: #{attribute})"
          next
        end

        search_field_class.new(
          attribute,
          type,
          label,
          model,
          f,
          @ransack_options
        ).prepare
      end.compact.select(&:render?)
    end

    def model
      @scoped_resource.klass
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

    def default_search_attributes
      @dashboard.attribute_types.select { |key, _value| @dashboard.collection_attributes.include?(key) }
    end

    def search_field_class_by(type)
      input_type = type.is_a?(Administrate::Field::Deferred) ? type.deferred_class.to_s : type.to_s
      AdministrateRansack.filters[input_type]
    end
  end
end
