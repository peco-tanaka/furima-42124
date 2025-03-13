require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it 'すべての項目が正しく入力されている場合' do
      expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      context '空の入力に対するチェック' do
        it 'nameが空では出品できない' do
          @item.name = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it 'descriptionが空では出品できない' do
          @item.description = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end
        it 'priceが空では出品できない' do
          @item.price = ""
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it 'imageが空では出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
      end

      context 'データ型が異なる場合のチェック' do
        it 'priceが数値以外では出品できない' do
          @item.price = "test"
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is not a number")
        end
        it 'condition_idが数値以外では出品できない' do
          @item.condition_id = "abc"
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition can't be blank")
        end
        it 'shipping_fee_status_idが数値以外では出品できない' do
          @item.shipping_fee_status_id = "abc"
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
        end
        it 'shipping_day_idが数値以外では出品できない' do
          @item.shipping_day_id = "abc"
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping day can't be blank")
        end
        it 'prefecture_idが数値以外では出品できない' do
          @item.prefecture_id = "abc"
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'category_idが数値以外では出品できない' do
          @item.category_id = "abc"
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end
      end

      context 'idが1の場合のチェック' do
        it 'condition_idが1では出品できない' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition can't be blank")
        end
        it 'shipping_fee_status_idが1では出品できない' do
          @item.shipping_fee_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
        end
        it 'shipping_day_idが1では出品できない' do
          @item.shipping_day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping day can't be blank")
        end
        it 'prefecture_idが1では出品できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'category_idが1では出品できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end
      end

      context 'その他出品できない場合のチェック' do
        it 'nameが41文字以上だと出品できない' do
          @item.name = Faker::Lorem.characters(number: 41)
          @item.valid?
          expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
        end
        it 'descriptionが1001文字以上だと出品できない' do
          @item.description = Faker::Lorem.characters(number: 1001)
          @item.valid?
          expect(@item.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
        end
        it 'priceが299より小さければ出品できない' do
          @item.price = Faker::Number.between(from: 290, to: 299)
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
        end
        it 'priceが10,000,000より大きければ出品できない' do
          @item.price = Faker::Number.between(from: 10_000_000, to: 10_000_100)
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
        end
        it 'userが紐づいていなければ出品できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("User must exist")
        end
      end
    end
  end
end