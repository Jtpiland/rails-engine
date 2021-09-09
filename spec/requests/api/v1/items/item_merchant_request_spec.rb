require 'rails_helper'

RSpec.describe "Item Merchant API" do
  before :each do
    create_list(:merchant, 2)
    create_list(:item, 20, merchant: Merchant.first)
  end

  describe 'GET /api/v1/items/{item_id}/merchant' do
    it "can send information about an item's merchant" do

      get "/api/v1/items/#{Item.first.id}/merchant"

      expect(response).to be_successful

      item_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(item_merchant.count).to eq(1)
      expect(item_merchant[:data]).to have_key(:id)
      expect(item_merchant[:data][:id]).to be_a(String)
      expect(item_merchant[:data][:attributes]).to have_key(:name)
      expect(item_merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'returns a 404 when a bad id(integer) is input' do 
      get "/api/v1/items/1/merchant"

      expect(response.status).to eq(404)
    end

    it 'returns a 404 when an id is input as a string' do

      id = "1"
      get "/api/v1/items/#{id}/merchant"

      expect(response.status).to eq(404)
    end
  end
end
