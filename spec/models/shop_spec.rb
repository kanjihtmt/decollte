require 'rails_helper'

describe Shop do
  describe 'validations' do
    describe '#name' do
      it '店舗名は必須であること' do
        is_expected.to validate_presence_of(:name)
      end

      it '店舗名は100桁まで入力可能なこと' do
        is_expected.to validate_length_of(:name).is_at_most(100)
      end
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to(:brand) }
  end
end
