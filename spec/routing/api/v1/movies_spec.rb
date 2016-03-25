require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :routing do
  it { expect(get('/api/v1/movies')).to route_to ("api/v1/movies#index") }
  it { expect(post('/api/v1/movies/import')).to route_to ("api/v1/movies#import") }
  it { expect(get('/api/v1/movies/1')).to route_to('api/v1/movies#show', {:id => "1" }) }
  it { expect(put('/api/v1/movies/1')).to route_to('api/v1/movies#update', {:id  => "1" }) }
end
