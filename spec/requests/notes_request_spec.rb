# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe 'Notes', type: :request do
  it 'renders the index page' do
    user = create(:user)
    login_user(user)

    get notes_path

    expect(response).to render_template(:index)
    expect(response.status).to eq(200)
  end

  it 'creates a note and redirects to the show page' do
    user = create(:user)
    login_user(user)

    get new_note_path
    expect(response).to render_template(:new)

    post notes_path, params: { note: { user_id: user.id, subject: 'My first note', text: 'This is a test' } }

    expect(response).to redirect_to(assigns(:note))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include(I18n.t('notes.create.success'))
  end

  it 'fails to create a note and returns to the new page' do
    user = create(:user)
    login_user(user)

    get new_note_path
    expect(response).to render_template(:new)

    post notes_path, params: { note: { user_id: user.id, subject: nil, text: 'This is a test' } }
    expect(response).to render_template(:new)
  end

  it 'successfully updates a note' do
    user = create(:user)
    login_user(user)
    user_note = create(:note, user_id: user.id)

    get edit_note_path(user_note.id)
    expect(response).to render_template(:edit)

    put note_path, params: { note: { user_id: user.id, subject: 'Updated Information', text: user_note.text } }
    expect(response).to redirect_to(assigns(:note))
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include(I18n.t('notes.update.success'))
  end

  it 'fails to update a note and returns to the edit page' do
    user = create(:user)
    login_user(user)
    user_note = create(:note, user_id: user.id)

    get edit_note_path(user_note.id)
    expect(response).to render_template(:edit)

    put note_path, params: { note: { user_id: user.id, subject: nil, text: user_note.text } }
    expect(response).to render_template(:edit)
  end

  it 'destroys note' do
    user = create(:user)
    login_user(user)
    user_note = create(:note, user_id: user.id)

    delete "/notes/#{user_note.id}"
    expect(response).to redirect_to(root_path)
    expect(request.flash[:notice]).to include(I18n.t('notes.destroy.success'))
  end

  it 'fails to destroy a non-existent note' do
    user = create(:user)
    login_user(user)

    delete '/notes/4'
    expect(response).to redirect_to(root_path)
    expect(request.flash[:alert]).to include(I18n.t('notes.destroy.fail'))
  end
end
# rubocop: enable Metrics/BlockLength
#
