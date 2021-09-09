class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    if params['quantity'] && params['quantity'].empty? == false && params['quantity'].to_i != 0 && params['quantity'].to_i > 0
      merchants = Merchant.top_merchants_by_revenue(params['quantity'].to_i)
      render json: MerchantNameRevenueSerializer.new(merchants)
    else
      render status: :bad_request
    end
  end
end
