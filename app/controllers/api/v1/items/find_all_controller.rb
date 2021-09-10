class Api::V1::Items::FindAllController < ApplicationController

  def index
    items = Item.where('name iLIKE ?', "%#{params['name']}%")

    if params['name'] && params['name'].empty? == false
      render json: ItemSerializer.new(items)
    else
      render json: {data:{}}, :status => :bad_request
    end
  end
end
