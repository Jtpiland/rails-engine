class Api::V1::Merchants::FindController < ApplicationController

  def index
    merchant = Merchant.where('name iLIKE ?', "%#{params['name']}%").order(:name).first

    if merchant == nil
      payload = { data:
        { status: 200
          }
        }
      render json: payload
    elsif params['name'] && Merchant.exists?(:id => merchant.id) && params['name'].empty? == false
      render json: MerchantSerializer.new(merchant)
    else
      render :status => :bad_request
    end
  end
end
