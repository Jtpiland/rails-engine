class Api::V1::Merchants::FindController < ApplicationController

  def index
    merchant = Merchant.where('name iLIKE ?', "%#{params['name']}%").order(:name).first

    render json: MerchantSerializer.new(merchant)
  end
end
