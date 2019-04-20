require'rails_helper'
describe Administrator do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:administrator)).to be_valid
  end
end
