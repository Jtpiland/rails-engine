require 'rails_helper'

RSpec.describe "Items API" do
  describe 'GET /api/vi/items' do
    it 'sends a list of items' do
      create_list(:item, 30)

      get '/api/v1/items', params: { page: 1 }

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end
  end

  describe 'POST /api/v1/items' do
    let(:valid_attributes) { { name: 'Item', description: 'Description', unit_price: 150.0, merchant_id: Merchant.first.id } }

    before :each do
      create_list(:merchant, 2)
      post '/api/v1/items', params: valid_attributes
    end

    describe 'create and delete' do

      it 'can create an item' do
        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)

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

      it 'can delete an item' do
        delete "/api/v1/items/#{Item.first.id}"

        expect(response).to be_successful
      end
    end
  end
end
