require 'rails_helper'

RSpec.describe 'Items by Revenue DESC' do
  before :each do
    @item1 = create(:item)
    @item2 = create(:item)
    @item3 = create(:item)
    @item4 = create(:item)
    @item5 = create(:item)
    @item6 = create(:item)
    @item7 = create(:item)
    @item8 = create(:item)
    @item9 = create(:item)
    @item10 = create(:item)
    @item11 = create(:item)
    @item12 = create(:item)

    @invoice1 = create(:invoice, status: 'shipped')
    @invoice2 = create(:invoice, status: 'shipped')
    @invoice3 = create(:invoice, status: 'shipped')
    @invoice4 = create(:invoice, status: 'shipped')
    @invoice5 = create(:invoice, status: 'shipped')
    @invoice6 = create(:invoice, status: 'shipped')
    @invoice7 = create(:invoice, status: 'shipped')
    @invoice8 = create(:invoice, status: 'shipped')
    @invoice9 = create(:invoice, status: 'shipped')
    @invoice10 = create(:invoice, status: 'shipped')
    @invoice11 = create(:invoice, status: 'shipped')
    @invoice12 = create(:invoice, status: 'pending')

    @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
    @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
    transaction3 = create(:transaction, invoice_id: @invoice3.id, result: 'success')
    @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: 'success')
    @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: 'success')
    @transaction6 = create(:transaction, invoice_id: @invoice6.id, result: 'success')
    @transaction7 = create(:transaction, invoice_id: @invoice7.id, result: 'success')
    @transaction8 = create(:transaction, invoice_id: @invoice8.id, result: 'success')
    @transaction9 = create(:transaction, invoice_id: @invoice9.id, result: 'success')
    @transaction10 = create(:transaction, invoice_id: @invoice10.id, result: 'success')
    @transaction11 = create(:transaction, invoice_id: @invoice11.id, result: 'success')
    @transaction12 = create(:transaction, invoice_id: @invoice12.id, result: 'failed')

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, unit_price: 10, quantity: 10)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, unit_price: 10, quantity: 9)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id, unit_price: 10, quantity: 8)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, unit_price: 10, quantity: 7)
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, unit_price: 10, quantity: 6)
    @invoice_item6 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice6.id, unit_price: 10, quantity: 5)
    @invoice_item7 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice7.id, unit_price: 10, quantity: 4)
    @invoice_item8 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice8.id, unit_price: 10, quantity: 3)
    @invoice_item9 = create(:invoice_item, item_id: @item9.id, invoice_id: @invoice9.id, unit_price: 10, quantity: 2)
    @invoice_item10 = create(:invoice_item, item_id: @item10.id, invoice_id: @invoice10.id, unit_price: 10, quantity: 2)
    @invoice_item11 = create(:invoice_item, item_id: @item11.id, invoice_id: @invoice11.id, unit_price: 10, quantity: 1)
    @invoice_item12 = create(:invoice_item, item_id: @item12.id, invoice_id: @invoice12.id, unit_price: 10, quantity: 1)
  end

  it 'can fetch that top 10 items by revenue' do

    get "/api/v1/revenue/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(10)

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
      expect(item[:attributes]).to have_key(:revenue)
      expect(item[:attributes][:revenue]).to be_a(Float)
    end
  end

  it 'can find the top item by revenue' do
    quantity = 1

    get "/api/v1/revenue/items?quantity=#{quantity}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(1)
    expect(item[:data].first[:id]).to eq((@item1.id).to_s)
  end

  it 'can return all items with revenue if the params quantity is too big' do
    quantity = 10000

    get "/api/v1/revenue/items?quantity=#{quantity}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].count).to eq(11)
  end

  it 'sends an error if the params quantity is less than zero (sad path)' do
    quantity = -5

    get "/api/v1/revenue/items?quantity=#{quantity}"

    expect(response).to_not be_successful
  end

  it 'returns an error if the params quantity is left blank (sad path)' do
    quantity = ""

    get "/api/v1/revenue/items?quantity=#{quantity}"

    expect(response).to_not be_successful
  end

  it 'returns an error if the params quantity is a string (sad path)' do
    quantity = "asdasd"

    get "/api/v1/revenue/items?quantity=#{quantity}"

    expect(response).to_not be_successful
  end
end
