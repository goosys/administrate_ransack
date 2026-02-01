# frozen_string_literal: true

Ransack.configure do |config|
  config.add_predicate 'lteq_end_of_day',
    arel_predicate: 'lteq',
    formatter: proc { |v| v.end_of_day },
    type: :date
end

if Gem.loaded_specs["ransack"]&.version.to_s == "4.4.0"
  module RansackCastArrayRevertPatch
    # Ransack 4.4.0 had a bug, and a partial revert was released in 4.4.1
    # ref: https://github.com/activerecord-hackery/ransack/pull/1645
    def casted_values_for_attribute(attr)
      validated_values.map { |v| v.cast(predicate.type || attr.type) }
    end
  end
  Ransack::Nodes::Condition.prepend(RansackCastArrayRevertPatch)
end
