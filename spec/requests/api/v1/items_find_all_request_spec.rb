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
  end
end
