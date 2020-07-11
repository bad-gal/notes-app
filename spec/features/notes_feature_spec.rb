# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.feature 'Notes' do
  scenario 'user creates a new note' do
    user = create(:user)
    login_user(user)

    visit root_path
    click_link I18n.t('notes.new')

    expect(page).to have_content('New note')
    fill_in 'Subject', with: 'Shopping List'
    fill_in 'Text', with: 'Eggs, Sugar, Milk, Bread'
    click_button I18n.t('notes.new')
    expect(page).to have_content(I18n.t('notes.create.success'))
  end

  scenario 'view a note' do
    user = create(:user)
    note = create(:note, user_id: user.id)
    login_user(user)

    visit root_path
    expect(page).to have_content(note.subject)
    click_link 'View'

    expect(page).to have_current_path(note_path(user.id))
    expect(page).to have_content(note.text)
  end

  scenario 'edit a note from home page' do
    user = create(:user)
    note = create(:note, user_id: user.id)
    login_user(user)

    visit root_path
    expect(page).to have_content(note.subject)
    click_link 'Edit'
    expect(page).to have_current_path(edit_note_path(user.id))
    expect(page).to have_button(I18n.t('notes.edit'))
  end

  scenario 'edit a note from note show page' do
    user = create(:user)
    note = create(:note, user_id: user.id)
    login_user(user)

    visit root_path
    expect(page).to have_content(note.subject)

    click_link 'View'
    expect(page).to have_current_path(note_path(user.id))

    click_link 'Edit'
    expect(page).to have_current_path(edit_note_path(user.id))
    expect(page).to have_button(I18n.t('notes.edit'))
  end

  scenario 'update a note' do
    user = create(:user)
    note = create(:note, user_id: user.id)
    login_user(user)

    visit root_path
    expect(page).to have_content(note.subject)
    click_link 'Edit'
    fill_in 'Subject', with: 'Food list for Mum'
    click_button I18n.t('notes.edit')
    expect(page).to have_content(I18n.t('notes.update.success'))
    note.reload
    expect(note.subject).to eq('Food list for Mum')
  end

  scenario 'delete a note from home page' do
    user = create(:user)
    note = create(:note, user_id: user.id)
    login_user(user)

    visit root_path
    expect(page).to have_content(note.subject)
    click_link 'Delete'

    expect(page).to have_content(I18n.t('notes.destroy.success'))
    expect(Note.all).to be_empty
  end

  scenario 'delete a note from show page' do
    user = create(:user)
    note = create(:note, user_id: user.id)
    login_user(user)

    visit root_path
    expect(page).to have_content(note.subject)

    click_link 'View'
    expect(page).to have_current_path(note_path(user.id))

    click_link 'Delete note'
    expect(page).to have_content(I18n.t('notes.destroy.success'))
    expect(Note.all).to be_empty
  end
end
# rubocop: enable Metrics/BlockLength
