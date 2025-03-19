# frozen_string_literal: true

RSpec.describe 'DateTime filter' do
  let(:post3) { Post.third }

  it 'filters the posts by datetime', :aggregate_failures do
    visit '/admin/posts'

    datetime = DateTime.tomorrow
    fill_in('q[created_at_gteq]', with: datetime)
    find('input[type="submit"]').click

    expect(page).to have_current_path %r{/admin/posts\?.+q%5Bcreated_at_gteq%5D=#{datetime}.*}
    expect(page).to have_css('.js-table-row', count: 1)
    expect(page).to have_css('.js-table-row a.action-show', text: post3.title)
  end
end
