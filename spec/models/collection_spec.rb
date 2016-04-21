require 'rails_helper'

describe Collection, :model do

  it "has a valid factory" do
    collection = build(:collection)
    expect(collection).to be_valid
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :user }

end
