require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it '必須項目が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end
      it 'building_nameが空でも保存できる' do
        @order_form.building_name = ""
        expect(@order_form).to be_valid
      end
    end

    context '購入できない場合'do
      context '空の入力に対するチェック' do
        it 'postal_codeが空の場合' do
          @order_form.postal_code = ""
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
        end
        it 'prefectureが空の場合' do
          @order_form.prefecture_id = ""
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'cityが空の場合' do
          @order_form.city = ""
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("City can't be blank")
        end
        it 'addressが空の場合' do
          @order_form.address = ""
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Address can't be blank")
        end
        it 'phone_numberが空の場合' do
          @order_form.phone_number = ""
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'user_idが空の場合' do
          @order_form.user_id = nil
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("User can't be blank")
        end
        it 'item_idが空の場合' do
          @order_form.item_id = nil
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Item can't be blank")
        end
        it 'tokenが空の場合' do
          @order_form.token = ""
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Token can't be blank")
        end
      end
      context '電話番号の入力チェック' do
        it 'phone_numberは数字でなければ登録できない' do
          @order_form.phone_number = "abcdefghij"
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Phone number is invalid. Input only number")
        end
        it 'phone_numberは9文字以下だと登録できない' do
          @order_form.phone_number = "11111111"
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Phone number is too short")
        end
        it 'phone_numberは12文字以上だと登録できない' do
          @order_form.phone_number = "111111111111"
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Phone number is too long")
        end
        it 'phone_numberは - が含まれていると登録できない' do
          @order_form.phone_number = "111-1111-1111"
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Phone number is invalid. Input only number")
        end
      end
      context 'その他のチェック' do
        it 'postal_codeは４文字目に - がなければ登録できない' do
          @order_form.postal_code = "1111111"
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Postal code invalid. Enter it as follows (e.g. 123-4567)")
        end
        it 'prefecture_idが1の場合は登録できない' do
          @order_form.prefecture_id = "1"
          @order_form.valid?
          expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
        end
      end
    end
  end
end
