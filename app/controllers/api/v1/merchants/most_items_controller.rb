class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    if params['quantity'] && params['quantity'].empty? == false && params['quantity'].to_i != 0 && params['quantity'].to_i > 0
      merchants = Merchant.top_merchants_by_items_sold(params['quantity'].to_i)
      render json: ItemsSoldSerializer.new(merchants)
    else
      render json: {error: "must provide a valid quantity"}, status: :bad_request
    end
  end
end
