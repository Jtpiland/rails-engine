require 'rails_helper'

RSpec.describe 'Merchant Revenue' do
  before :each do
    @merchant1 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)

    @invoice1 = create(:invoice, status: 'shipped')

    @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, unit_price: 10, quantity: 10)
  end

  it 'can fetch revenue by merchant id' do
    merchant_id = @merchant1.id

    get "/api/v1/revenue/merchants/#{merchant_id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant.count).to eq(1)
    expect(merchant[:data][:attributes][:revenue]).to eq(100.0)
  end

  it 'returns error (404) if the params id is bad' do
    merchant_id = 12091209109092

    get "/api/v1/revenue/merchants/#{merchant_id}"

    expect(response).to_not be_successful
  end
end
