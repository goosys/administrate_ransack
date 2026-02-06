# frozen_string_literal: true

module AdministrateRansack
  # FILTERS = {
  #   'Administrate::Field::BelongsTo' => 'field_belongs_to',
  #   'Administrate::Field::Boolean' => 'field_boolean',
  #   'Administrate::Field::Date' => 'field_date',
  #   'Administrate::Field::DateTime' => 'field_datetime',
  #   'Administrate::Field::Email' => 'field_string',
  #   'Administrate::Field::HasMany' => 'field_has_many',
  #   'Administrate::Field::Number' => 'field_number',
  #   'Administrate::Field::Select' => 'field_select',
  #   'Administrate::Field::String' => 'field_string',
  #   'Administrate::Field::Text' => 'field_string'
  # }.freeze
  FILTERS = {
    'Administrate::Field::BelongsTo' => AdministrateRansack::SearchField::BelongsTo,
    'Administrate::Field::Boolean' => AdministrateRansack::SearchField::Boolean,
    'Administrate::Field::Date' => AdministrateRansack::SearchField::Date,
    'Administrate::Field::DateTime' => AdministrateRansack::SearchField::Datetime,
    'Administrate::Field::HasMany' => AdministrateRansack::SearchField::HasMany,
    'Administrate::Field::Number' => AdministrateRansack::SearchField::Number,
    'Administrate::Field::Select' => AdministrateRansack::SearchField::Select,
    'Administrate::Field::String' => AdministrateRansack::SearchField::String,
    'Administrate::Field::Text' => AdministrateRansack::SearchField::String,
  }.freeze

  @@filters = FILTERS.dup

  def self.add_filter(field_name, component_name)
    @@filters[field_name.to_s] = component_name.to_s
  end

  def self.remove_filter(field_name)
    @@filters.except!(field_name)
  end

  def self.filters
    @@filters
  end
end
