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

      expect(item_merchant[:data].count).to eq(1)
      expect(item_merchant[:data].first).to have_key(:id)
      expect(item_merchant[:data].first[:id]).to be_a(String)
      expect(item_merchant[:data].first[:attributes]).to have_key(:name)
      expect(item_merchant[:data].first[:attributes][:name]).to be_a(String)
    end
  end
end
