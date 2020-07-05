# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid' do
    expect(create(:user)).to be_valid
  end

  it 'is not valid without email' do
    expect { create(:user, email: nil) }
      .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank")
  end

  it 'is not valid without password' do
    expect { create(:user, password: nil) }
      .to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank")
  end

  it 'is not valid if email already registered' do
    original_user = create(:user)

    expect { User.create!(email: original_user.email, password: '12345chico') }
      .to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Email has already been taken')
  end
end
