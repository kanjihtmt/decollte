require 'rails_helper'

describe Administrator do
  it 'has a valid factory' do
    expect(build(:administrator)).to be_valid
  end

  describe 'validations' do
    describe '#name' do
      it 'アカウント名は必須であること' do
        is_expected.to validate_presence_of(:username)
      end

      it 'アカウント名は4文字以上であること' do
        is_expected.to validate_length_of(:username).is_at_least(4)
      end

      it 'アカウント名は20文字以下であること' do
        is_expected.to validate_length_of(:username).is_at_most(20)
      end
    end

    describe '#password' do
      it 'パスワードは必須であること' do
        is_expected.to validate_presence_of(:password)
      end

      it 'パスワードは4文字以上であること' do
        is_expected.to validate_length_of(:password).is_at_least(4)
      end
    end
  end
end
