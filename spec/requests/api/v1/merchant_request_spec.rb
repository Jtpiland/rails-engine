require 'rails_helper'

RSpec.describe "Merchant Show API" do
  it 'sends information about a particular merchant' do
    create_list(:merchant, 2)

    get "/api/v1/merchants/#{Merchant.first.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
  end
end
