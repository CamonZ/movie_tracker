require 'rails_helper'

RSpec.describe Api::V1::CollectionsController, type: :routing do
  it { expect(get('/api/v1/collections')).to route_to("api/v1/collections#index") }
  it { expect(post('/api/v1/collections')).to route_to("api/v1/collections#create") }
  it { expect(get('/api/v1/collections/1')).to route_to('api/v1/collections#show', { id: "1" }) }
  it { expect(put('/api/v1/collections/1')).to route_to('api/v1/collections#update', { id: "1" }) }
  it { expect(delete('/api/v1/collections/1')).to route_to('api/v1/collections#destroy', { id: "1" }) }

  it { expect(post('/api/v1/collections/1/movies/add')).to route_to('api/v1/movies#add_to_collection', { collection_id: "1" } ) }
  it { expect(delete('/api/v1/collections/1/movies/remove')).to route_to('api/v1/movies#remove_from_collection', { collection_id: "1" } ) }

end
