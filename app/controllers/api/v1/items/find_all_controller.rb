class Api::V1::Items::FindAllController < ApplicationController

  def index
    items = Item.where('name iLIKE ?', "%#{params['name']}%")

    if params['name'] && params['name'].empty? == false
      render json: ItemSerializer.new(items)
    elsif !params['name'] || params['name'].empty?
      render :status => :bad_request
    else
      render :status => :bad_request
    end
  end
end
