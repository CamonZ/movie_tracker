require 'rails_helper'

#require "#{Rails.pwd}/lib/domain/omdb/importer.rb"

RSpec.describe MoviesImporterJob do
  describe "#import" do
    let (:user) { create(:user) }
    let (:imdb_id) { 'tt0468569' }
    let (:importer) { double("Importer") }

    before {  allow(subject).to receive(:importer).and_return(importer) }

    describe "when there are no errors" do
      it "calls the OMDB importer" do
        expect(importer).to receive(:import).with('tt0468569', user.id)

        subject.import('tt0468569', user.id)
      end
    end

    describe "when the movie with the same imdb id has already been imported" do
      it "catches the ActiveRecord error" do
        expect(importer).to receive(:import).and_raise(ActiveRecord::RecordInvalid)
        expect { subject.import(imdb_id, user.id) }.to_not raise_error { ActiveRecord::RecordInvalid }
      end
    end
  end
end
