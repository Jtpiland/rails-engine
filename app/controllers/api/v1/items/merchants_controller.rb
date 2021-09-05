class Api::V1::Items::MerchantsController < ApplicationController

  def index
    item = Item.find(params[:item_id])
    merchant = Merchant.where('id = ?', item.merchant_id)

    render json: MerchantSerializer.new(merchant)
  end
end
