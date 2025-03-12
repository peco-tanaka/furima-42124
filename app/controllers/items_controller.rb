class ItemsController < ApplicationController
  def index
    # @ = .all
  end

  def new
    @item = Item.new
  end


  private
  def item_params
    params.require(:item).permit(
      :image)
  end

end