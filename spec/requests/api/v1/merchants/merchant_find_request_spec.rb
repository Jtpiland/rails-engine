require 'rails_helper'

RSpec.describe 'Merchant Find API' do
  before :each do
    create(:merchant, name: 'Kevin')
    create(:merchant, name: 'Todd')
  end

  describe 'GET /api/v1/merchants/find' do
    it 'can find a single merchant based on a search fragment' do

      get "/api/v1/merchants/find?name=Kev"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:attributes][:name]).to eq('Kevin')
    end

    it 'sends an error message if the no merchant matches the search fragment' do

      get "/api/v1/merchants/find?name=Dog"

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data][:status]).to eq(200)
    end

    it 'sends an error if no name param is given' do

      get "/api/v1/merchants/find?name="

      expect(response).to_not be_successful
    end

  end
end
