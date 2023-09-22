# frozen_string_literal: true

module AdministrateRansack
  module Configuration

    mattr_accessor :options

    self.options = {
      has_many_field_type_default: :checkbox, # [:checkbox, :selectbox]
    }

    def configure
      yield self
    end

    def has_many_field_type_default=(field_type)
      self.options[:has_many_field_type_default] = [:checkbod, :select].include?(field_type.to_sym) ? field_type.to_sym : :checkbox
    end
  end
end
