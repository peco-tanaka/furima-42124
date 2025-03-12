class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  private
  def item_params
    params.require(:item).permit(:image)
  end
end