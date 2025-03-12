class ItemsController < ApplicationController
  def index
    # @ = .all
  end

  def new
    @item = Item.new
  end

end