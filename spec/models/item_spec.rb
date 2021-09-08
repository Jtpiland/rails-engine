require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

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

  describe '::class methods' do
    describe '::top_items_by_revenue' do
      it 'can find the top items by revenue for a specific quantity' do

        expect(Item.top_items_by_revenue(10)).to eq([@item1, @item2, @item3, @item4, @item5, @item6, @item7, @item8, @item9, @item10])

        expect(Item.top_items_by_revenue(1)).to eq([@item1])
      end
    end
  end
end
