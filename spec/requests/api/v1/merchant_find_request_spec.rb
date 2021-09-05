require 'rails_helper'

RSpec.describe 'Merchant Find API' do
  before :each do
    create_list(:merchant, 2)
  end

  describe 'GET /api/v1/merchants/find' do
    it 'can find a single merchant based on a search' do

      get "/api/v1/merchants/find"

      expect(response).to be_successful
    end
  end
end
