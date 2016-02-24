require 'rails_helper'

feature 'Create post', %q{
  In order to get response
  As an authenticated user
  I want to be able to create post
} do

  scenario 'Authenticated user creates the post' do
    User.create!(email: 'user@user.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@user.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

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
