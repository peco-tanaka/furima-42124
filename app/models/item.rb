class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  has_one_attached :image
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee_status
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :condition_id, :shipping_fee_status_id, :shipping_day_id, :prefecture_id, :category_id,
            presence: true

  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
end