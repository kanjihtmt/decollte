require 'rails_helper'

describe Brand do
  describe 'validations' do
    describe '#name' do
      it 'ブランド名は必須であること' do
        is_expected.to validate_presence_of(:name)
      end
    end
  end
end
