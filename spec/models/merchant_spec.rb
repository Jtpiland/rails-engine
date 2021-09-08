require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    @merchant6 = create(:merchant)
    @merchant7 = create(:merchant)
    @merchant8 = create(:merchant)
    @merchant9 = create(:merchant)
    @merchant10 = create(:merchant)
    @merchant11 = create(:merchant)
    @merchant12 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant2.id)
    @item3 = create(:item, merchant_id: @merchant3.id)
    @item4 = create(:item, merchant_id: @merchant4.id)
    @item5 = create(:item, merchant_id: @merchant5.id)
    @item6 = create(:item, merchant_id: @merchant6.id)
    @item7 = create(:item, merchant_id: @merchant7.id)
    @item8 = create(:item, merchant_id: @merchant8.id)
    @item9 = create(:item, merchant_id: @merchant9.id)
    @item10 = create(:item, merchant_id: @merchant10.id)
    @item11 = create(:item, merchant_id: @merchant11.id)
    @item12 = create(:item, merchant_id: @merchant12.id)

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

  describe '::class methods' do
    describe '::top_merchants_by_revenue' do
      it 'can find the top merchants by revenue for a specific quantity' do

        expect(Merchant.top_merchants_by_revenue(10)).to eq([@merchant1, @merchant2, @merchant3, @merchant4, @merchant5, @merchant6, @merchant7, @merchant8, @merchant9, @merchant10])
      end
    end
  end
end
