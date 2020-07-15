# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User visits settings page' do
  scenario 'visiting user can not access page' do
    visit settings_path

    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'logged in user can access page' do
    sign_up_user
    visit settings_path
    expect(page).to have_content(I18n.t('settings.index.title'))
  end

  scenario 'user can change email address' do
    sign_up_user
    visit settings_path

    click_button I18n.t('settings.index.edit_button')
    expect(page).to have_current_path(edit_user_registration_path)

    fill_in 'Email', with: 'new_email@noname.com'
    fill_in 'Current password', with: '1234piano'
    click_button 'Update'

    expect(page).to have_content(I18n.t('devise.registrations.updated'))
    expect(page).to have_current_path(notes_path)
  end

  scenario 'user can change password' do
    sign_up_user
    visit settings_path

    click_button I18n.t('settings.index.edit_button')
    expect(page).to have_current_path(edit_user_registration_path)

    fill_in 'Password', with: 'myNewP0ss'
    fill_in 'Password confirmation', with: 'myNewP0ss'
    fill_in 'Current password', with: '1234piano'
    click_button 'Update'

    expect(page).to have_content(I18n.t('devise.registrations.updated'))
    expect(page).to have_current_path(notes_path)
  end

  scenario 'user can delete account' do
    sign_up_user
    visit settings_path
    click_button I18n.t('settings.index.delete_button')

    expect(page).to have_content(I18n.t('devise.registrations.destroyed'))
  end
end
