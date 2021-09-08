class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  def self.top_items_by_revenue(params_quantity)
    joins(invoice_items: { invoice: :transactions })
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group('items.id')
    .select("items.*, SUM(invoice_items.quantity *  invoice_items.unit_price) AS revenue")
    .order('revenue DESC')
    .limit(params_quantity)
  end
end
