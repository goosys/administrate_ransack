# frozen_string_literal: true

RSpec.describe 'Ransack::Predicate', :aggregate_failures do
  it 'adds the lteq_end_of_day predicate' do
    predicate = Ransack::Predicate.named('lteq_end_of_day')

    expect(predicate).to be_present
    expect(predicate.name).to eq('lteq_end_of_day')
    expect(Post.ransack(created_at_lteq_end_of_day: '2025-01-31').result.to_sql).to eq "SELECT \"posts\".* FROM \"posts\" WHERE \"posts\".\"created_at\" <= '2025-01-31 23:59:59.999999'"
  end
end
