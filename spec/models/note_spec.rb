# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  context 'with a valid user' do
    let(:user) { create(:user) }

    it 'is valid' do
      expect(create(:note, user: user)).to be_valid
    end

    it 'is not valid without a subject' do
      expect { create(:note, subject: nil, user: user) }
        .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Subject can't be blank")
    end
  end

  it 'is not valid without a user' do
    expect { create(:note, user: nil) }
      .to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: User must exist')
  end
end
