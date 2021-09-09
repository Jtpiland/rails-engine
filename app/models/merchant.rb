class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.top_merchants_by_revenue(params_quantity)
    joins(items: { invoice_items: { invoice: :transactions }})
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group('merchants.id')
    .select("merchants.*, SUM(invoice_items.quantity *  invoice_items.unit_price) AS revenue")
    .order('revenue DESC')
    .limit(params_quantity)
  end

  def self.top_merchants_by_items_sold(params_quantity)
    joins(items: { invoice_items: { invoice: :transactions }})
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group('merchants.id')
    .select("merchants.*, SUM(invoice_items.quantity) AS count")
    .order('count DESC')
    .limit(params_quantity)
  end
end
