require 'rails_helper'

describe Shop do
  describe 'validations' do
    describe '#name' do
      it '店舗名は必須であること' do
        is_expected.to validate_presence_of(:name)
      end
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:brand) }
  end
end
