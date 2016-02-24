require 'rails_helper'

feature 'Create post', %q{
  In order to get response
  As an authenticated user
  I want to be able to create post
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates the post' do
    sign_in(user)

    visit '/posts'
    click_on 'Create post'
    fill_in 'Title', with: 'Post'
    fill_in 'Text', with: 'text text text'
    click_on 'Create'

    expect(page).to have_content 'Your post successfully created.'
  end

  scenario 'Non-authenticated user tries to create post' do
    visit '/posts'
    click_on 'Create post'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
