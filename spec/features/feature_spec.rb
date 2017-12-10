require 'pry'

feature 'entering player name' do
  scenario 'players enter names' do
    visit '/'
    fill_in('name', with: 'Kesha')
    click_button('Play')
    # sign_in_and_play
    expect(page).to have_content("Kesha VS CPU")
  end
end
