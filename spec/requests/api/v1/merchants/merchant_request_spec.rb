require 'rails_helper'

RSpec.describe "Merchant Show API" do
  it 'sends information about a particular merchant' do
    create_list(:merchant, 2)

    get "/api/v1/merchants/#{Merchant.first.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data].count).to eq(3)
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'returns a 404 when a bad id(integer) is input' do
		get "/api/v1/merchants/1"

		expect(response.status).to eq(404)
	end
end
