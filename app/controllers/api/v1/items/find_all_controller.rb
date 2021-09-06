class Api::V1::Items::FindAllController < ApplicationController

  def index
    items = Item.where('name iLIKE ?', "%#{params['name']}%")

    render json: ItemSerializer.new(items)
  end
end
