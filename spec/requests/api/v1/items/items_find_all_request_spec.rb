require 'rails_helper'

RSpec.describe 'Items Find All API' do
  before :each do
    create_list(:item, 10, name: 'Can Opener')
    create_list(:item, 10, name: 'Can Koozie')
    create_list(:item, 10, name: 'Drums')
  end

  describe 'GET /api/v1/items/find_all' do
    it 'can find all items through search' do
      get "/api/v1/items/find_all?name=can"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
    end

    it 'returns a successful response when the name does not match' do
      get "/api/v1/items/find_all?name=zzz"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(0)
    end

    it 'returns an error if no params search is entered ' do

      get "/api/v1/items/find_all?name="

      expect(response).to_not be_successful

      items = JSON.parse(response.body, symbolize_names: true)
      
      expect(items[:data]).to eq({})
    end
  end
end
