require 'rails_helper'

RSpec.describe 'Items Find All API' do
  before :each do
    create_list(:item, 30)
  end

  describe 'GET /api/v1/items/find_all' do
    it 'can find all items through search' do
      get "/api/v1/items/find_all"

      expect(response).to be_successful
    end
  end
end
