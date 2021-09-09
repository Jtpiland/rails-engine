class Api::V1::MerchantsController < ApplicationController

  def index
    if params[:page].to_i >= 1
      merchants = Merchant.paginate(page: params[:page])
    elsif params[:per_page]
      merchants = Merchant.paginate(page: 1, per_page: params[:per_page])
    else
      merchants = Merchant.paginate(page: 1)
    end
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  end
end
