require 'rails_helper'

RSpec.describe "Item Show API" do
  before :each do
    create_list(:item, 2)
  end

  describe 'GET /api/vi/items/#{item_id}'
    it 'sends information about a particular item' do

      get "/api/v1/items/#{Item.first.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data].count).to eq(3)
      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
    end

  describe 'PUT /api/v1/items/#{item_id}' do
    let(:valid_attributes) { { name: 'Updated Name'} }

    it 'can update information about a particular item' do

      put "/api/v1/items/#{Item.first.id}", params: valid_attributes
      # params: JSON.generate({item: valid_attributes})
      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq('Updated Name')
    end
  end
end
