require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be created with password and password_confirmation fields' do
      user = User.new(
        email: 'jd@ca',
        first_name: 'John',
        last_name: 'Doe',
        password: '1111',
        password_confirmation: '1111'
      )
      expect(user).to be_valid
    end

    it 'should require unique emails (not case sensitive)' do
      user1 = User.create(
        email: 'test@test.COM',
        first_name: 'John',
        last_name: 'Doe',
        password: '1111',
        password_confirmation: '1111'
      )
      user2 = User.new(
        email: 'TEST@TEST.com',
        first_name: 'Jane',
        last_name: 'Smith',
        password: '1111',
        password_confirmation: '1111'
      )
      expect(user2).not_to be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require email, first name, and last name' do
      user = User.new(
        password: '1111',
        password_confirmation: '1111'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include(
        "Email can't be blank",
        "First name can't be blank",
        "Last name can't be blank"
      )
    end

    it 'should have password minimum length' do
      user = User.new(
        email: 'jd@ca',
        first_name: 'John',
        last_name: 'Doe',
        password: '111',
        password_confirmation: '111'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'jd@ca',
        first_name: 'John',
        last_name: 'Doe',
        password: '1111',
        password_confirmation: '1111'
      )
    end

    it 'should return user if successfully authenticated' do
      user = User.authenticate_with_credentials('jd@ca', '1111')
      expect(user).to eq(@user)
    end

    it 'should return nil if not successfully authenticated' do
      user = User.authenticate_with_credentials('jd@ca', '2222')
      expect(user).to be nil
    end

    it 'should handle email with leading/tailing spaces' do
      user = User.authenticate_with_credentials(' jd@ca ', '1111')
      expect(user).to eq(@user)
    end

    it 'should handle email with wrong cases' do
      user = User.authenticate_with_credentials('JD@ca', '1111')
      expect(user).to eq(@user)
    end
  end
end