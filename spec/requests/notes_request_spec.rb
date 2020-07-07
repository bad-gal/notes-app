# frozen_string_literal: true

require 'rails_helper'

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
end
