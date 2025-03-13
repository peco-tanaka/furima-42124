class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # @ = .all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # flash[:success] = "Item successfully created"
      redirect_to root_path
    else
      # flash[:error] = "Something went wrong"
      render 'new'
    end
  end


  private
  def item_params
    params.require(:item).permit(
      :name, :description, :price, :user_id,
      :condition_id, :shipping_fee_status_id, :shipping_day_id, :prefecture_id, :category_id,
      :image).merge(user_id: current_user.id)
  end
end