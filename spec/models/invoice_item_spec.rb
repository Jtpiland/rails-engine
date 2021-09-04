require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { validate_presence_of(:quantity) }
    it { validate_presence_of(:unit_price) }
  end
end
