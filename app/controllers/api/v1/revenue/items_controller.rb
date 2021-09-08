class Api::V1::Revenue::ItemsController < ApplicationController

  def index
    if !params['quantity']
      items = Item.top_items_by_revenue(10)
      render json: ItemRevenueSerializer.new(items)
    elsif params['quantity'].empty? == false && params['quantity'].to_i != 0 && params['quantity'].to_i > 0 
      items = Item.top_items_by_revenue(params['quantity'].to_i)
      render json: ItemRevenueSerializer.new(items)
    else
      render status: :bad_request
    end
  end
end
