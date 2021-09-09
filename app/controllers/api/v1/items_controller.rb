class Api::V1::ItemsController < ApplicationController

  def index
    if params[:page].to_i >= 1
      items = Item.paginate(page: params[:page])
    elsif params[:per_page]
      items = Item.paginate(page: 1, per_page: params[:per_page])
    else
      items = Item.paginate(page: 1)
    end
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: 201
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
