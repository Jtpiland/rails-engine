class Api::V1::Merchants::FindController < ApplicationController

  def index
    merchant = Merchant.where('name LIKE ?', %params[:search]%).first
    render json: MerchantSerializer.new(merchant)
  end
end
