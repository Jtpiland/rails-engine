require 'rails_helper'

RSpec.describe "Item Show API" do
  before :each do
    create_list(:item, 2)
  end

  describe 'GET /api/vi/items/#{item_id}' do
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

    it 'returns a 404 when a bad id(integer) is input' do
  		get "/api/v1/items/1"

  		expect(response.status).to eq(404)
  	end

    it 'returns a 404 when an id is input as a string' do
      id = "1"
      get "/api/v1/items/#{id}"

      expect(response.status).to eq(404)
    end
  end

  describe 'PUT /api/v1/items/#{item_id}' do

    it 'can update information about a particular item by id' do

      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "Updated Name" }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

      item = Item.find_by(id: id)

      expect(response).to be_successful

      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Updated Name")
    end

    it 'returns a 404 when there is a bad merchant id(integer) is input' do

      create(:item)

      item_params = { merchant_id: 999999999 }
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{Item.first.id}", headers: headers, params: JSON.generate({item: item_params})

  		expect(response.status).to eq(400)
  	end

    it 'returns a 404 when an id is input as a string' do
      id = "1"

      patch "/api/v1/items/#{id}"

      expect(response.status).to eq(404)
    end
  end
end
