class ItemsController < ApplicationController
  def index
    # @ = .all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      # flash[:success] = "Item successfully created"
      redirect_to root_path
    else
      # flash[:error] = "Something went wrong"
      render 'new'
      puts "エラー数: #{@item.errors.count}"
      puts "エラー内容: #{@item.errors.full_messages.join(', ')}"
    end
  end


  private
  def item_params
    params.require(:item).permit(
      :name, :description, :price, :user_id,
      :condition_id, :shipping_fee_status_id, :shipping_day_id, :prefecture_id, :category_id,
      :image)
  end

end