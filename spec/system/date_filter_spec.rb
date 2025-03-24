# frozen_string_literal: true

RSpec.describe 'Date filter' do
  let(:post3) { Post.third }

  it 'filters the posts by date', :aggregate_failures do
    visit '/admin/posts'

    date = Time.zone.tomorrow
    fill_in('q[dt_gteq]', with: date)
    find('.filters-buttons input[type="submit"]').click

    expect(page).to have_current_path %r{/admin/posts\?.+q%5Bdt_gteq%5D=#{date}.*}
    expect(page).to have_css('.js-table-row', count: 1)
    expect(page).to have_css('.js-table-row a.action-show', text: post3.title)
  end

  it 'filters the posts by date range', :aggregate_failures do
    visit '/admin/posts'

    yesterday = Time.zone.yesterday
    tomorrow = Time.zone.tomorrow
    fill_in('q[dt_gteq]', with: yesterday)
    fill_in('q[dt_lteq_end_of_day]', with: tomorrow)
    find('.filters-buttons input[type="submit"]').click

    expect(page).to have_current_path %r{/admin/posts\?.+q%5Bdt_gteq%5D=#{yesterday}.*}
    expect(page).to have_current_path %r{/admin/posts\?.+q%5Bdt_lteq_end_of_day%5D=#{tomorrow}.*}
    expect(page).to have_css('.js-table-row', count: 3)
    expect(page).to have_css('.js-table-row a.action-show', text: post3.title)
  end
end
