require 'rails_helper'

RSpec.describe "Merchant Items API" do
  it 'sends information about a particular merchant_items' do
    create_list(:merchant, 2)
    create_list(:item, 20, merchant: Merchant.first)

    get "/api/v1/merchants/#{Merchant.first.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_items[:data].count).to eq(20)

    merchant_items[:data].each do |merchant_item|
      expect(merchant_item).to have_key(:id)
      expect(merchant_item[:id]).to be_a(String)
      expect(merchant_item[:attributes]).to have_key(:name)
      expect(merchant_item[:attributes][:name]).to be_a(String)
      expect(merchant_item[:attributes]).to have_key(:description)
      expect(merchant_item[:attributes][:description]).to be_a(String)
      expect(merchant_item[:attributes]).to have_key(:unit_price)
      expect(merchant_item[:attributes][:unit_price]).to be_a(Float)
      expect(merchant_item[:attributes]).to have_key(:merchant_id)
      expect(merchant_item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end
