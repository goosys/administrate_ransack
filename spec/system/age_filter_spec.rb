# frozen_string_literal: true

RSpec.describe 'Age filter' do
  let(:author1) { Author.first }

  it 'checks if the age filter is registered' do
    expect(AdministrateRansack.filters).to include('Administrate::Field::Age' => 'field_age')
  end

  it 'checks if the age filter input exists with min and max attributes' do
    visit '/admin/authors'

    expect(page).to have_selector('input[type="number"][name="q[age_gteq]"][id="q_age_gteq"][min="0"][max="100"]')
  end

  it 'filters the authors by age range', :aggregate_failures do
    visit '/admin/authors'

    fill_in('q[age_lteq]', with: '28')
    find('.filters-buttons input[type="submit"]').click

    expect(page).to have_current_path %r{/admin/authors\?.+q%5Bage_lteq%5D=28.*}
    expect(page).to have_css('.js-table-row', count: 2)
    expect(page).to have_css('.js-table-row a.action-show', text: author1.name)
  end
end
