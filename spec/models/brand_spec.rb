require 'rails_helper'

describe Brand do
  describe 'validations' do
    describe '#name' do
      it 'ブランド名は必須であること' do
        is_expected.to validate_presence_of(:name)
      end

      it 'ブランド名は20桁まで入力可能なこと' do
        is_expected.to validate_length_of(:name).is_at_most(20)
      end
    end
  end

  describe 'relations' do
    it { is_expected.to have_many(:shops) }
  end
end
