class Api::V1::ItemsController < ApplicationController

  def index
    if params[:page] && params[:per_page]
      items = Item.paginate(page: params[:page], per_page: params[:per_page])
    elsif params[:page].to_i >= 1
      items = Item.paginate(page: params[:page], per_page: 20)
    elsif params[:per_page]
      items = Item.paginate(page: 1, per_page: params[:per_page])
    else
      items = Item.paginate(page: 1, per_page: 20)
    end
    render json: ItemSerializer.new(items)
  end
end
