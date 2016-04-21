require 'rails_helper'

RSpec.describe User, type: :model do

  subject { build(:user) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "should have a valid factory" do
    user = build(:user)
    expect(user).to be_valid
  end
end
