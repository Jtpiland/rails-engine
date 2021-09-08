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
    headers = { "CONTENT_TYPE" => "application/json" }

    before :each do
      create_list(:merchant, 2)
      post '/api/v1/items', headers: headers, params: JSON.generate({item: valid_attributes})
    end

    describe 'create and delete' do

      it 'can create an item' do
        expect(response).to be_successful
        created_item = Item.last

        expect(created_item.name).to eq(valid_attributes[:name])
        expect(created_item.description).to eq(valid_attributes[:description])
        expect(created_item.unit_price).to eq(valid_attributes[:unit_price])
        expect(created_item.merchant_id).to eq(valid_attributes[:merchant_id])
      end

      it 'can delete an item' do
        expect(Item.count).to eq(1)

        item = Item.last

        delete "/api/v1/items/#{Item.last.id}"

        expect(response).to be_successful
        expect(Item.count).to eq(0)
        expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
