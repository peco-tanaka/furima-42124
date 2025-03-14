class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
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
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
      if @item.update(item_params)
        # flash[:success] = "Object was successfully updated"
        redirect_to item_path(@item)
      else
        # flash[:error] = "Something went wrong"
        render :edit
      end
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :description, :price,
      :condition_id, :shipping_fee_status_id, :shipping_day_id, :prefecture_id, :category_id,
      :image).merge(user_id: current_user.id)
  end

  def authorize_user
    @item = Item.find(params[:id])
    unless current_user == @item.user
      redirect_to root_path
      return
    end
  end
end