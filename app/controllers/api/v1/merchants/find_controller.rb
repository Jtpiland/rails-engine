class Api::V1::Merchants::FindController < ApplicationController

#   def index
#     if  Merchant.scoped_by_name('name iLIKE ?', "%#{params['name']}%").exists?
#
#       merchant = Merchant.where('name iLIKE ?', "%#{params['name']}%").order(:name).first
#
#       render json: MerchantSerializer.new(merchant)
#     else
#       render :status => :bad_request
#     end
#   end
# end

#   def index
#     merchant = Merchant.where('name iLIKE ?', "%#{params['name']}%").order(:name).first
#
#     if  Merchant.exists?(:id => merchant.id)
#       render json: MerchantSerializer.new(merchant)
#     else
#       payload = { data:
#       { error: 'blah blah',
#         status: 200
#         }
#       }
#       render json: payload, :status => :bad_request
#     end
#   end
# end



  def index
    merchant = Merchant.where('name iLIKE ?', "%#{params['name']}%").order(:name).first

    if params['name'] && Merchant.exists?(:id => merchant.id) && params['name'].empty? == false
      render json: MerchantSerializer.new(merchant)
    elsif !params['name'] || params['name'].empty?
      render :status => :bad_request
    else
      render :status => :bad_request
    end
  end
end
