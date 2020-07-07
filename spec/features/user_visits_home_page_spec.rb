# frozen_string_literal: true

RSpec.feature 'User visits home page' do
  scenario 'they see the main page' do
    visit root_path

    expect(page).to have_button(I18n.t('home.signup'))
    expect(page).to have_button(I18n.t('home.login'))
  end

  scenario 'they sign up to use the service' do
    sign_up_user

    # flash success message
    expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
  end

  scenario 'they can sign out of the service' do
    sign_up_user
    click_link I18n.t('home.logout')

    # flash success message
    expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
  end

  scenario 'they log in to service' do
    sign_up_user

    click_link I18n.t('home.logout')

    click_button(I18n.t('home.login'), match: :first)
    fill_in('Email', with: 'noname@noname.com')
    fill_in('Password', with: '1234piano')
    click_button('Log in')

    # flash success message
    expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    expect(page).to have_content(I18n.t('notes.index.header'))
  end

  def sign_up_user
    visit root_path
    click_button(I18n.t('home.signup'), match: :first)

    fill_in('Email', with: 'noname@noname.com')
    fill_in('Password', with: '1234piano')
    fill_in('Password confirmation', with: '1234piano')
    click_button('Sign up')
  end
end
