# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  it 'renders the index page' do
    get root_path

    expect(response).to render_template(:index)
    expect(response.status).to eq(200)
  end
end
