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
end
