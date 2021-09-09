class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    if params['quantity'] && params['quantity'].empty? == false && params['quantity'].to_i != 0 && params['quantity'].to_i > 0
      merchants = Merchant.top_merchants_by_revenue(params['quantity'].to_i)
      render json: MerchantNameRevenueSerializer.new(merchants)
    else
      render status: :bad_request
    end
  end

  def show
    if Merchant.exists?(:id => (params[:id]).to_i)
      merchant = Merchant.merchant_revenue_by_id((params['id']).to_i)
      render json: MerchantRevenueSerializer.new(merchant)
    else
      render status: 404
    end
  end
end
