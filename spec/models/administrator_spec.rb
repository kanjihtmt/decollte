require 'rails_helper'

describe Administrator do
  it 'has a valid factory' do
    expect(FactoryBot.build(:administrator)).to be_valid
  end
end
