require 'rails_helper'

RSpec.describe Movie, type: :model do

  it "has a valid factory" do
    movie = build(:movie)
    expect(movie).to be_valid
  end

  it { is_expected.to validate_presence_of(:imdb_id) }
  it { is_expected.to validate_presence_of(:title) }
end
