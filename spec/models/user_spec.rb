require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録機能' do
    context '登録できる場合' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上且つ1文字以上の英数字混合であれば登録できる' do
        @user.password = "11111a"
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end

    context '登録できない場合' do
      context '空の入力に対するチェック' do
        it '姓（last_name）が空では登録できない' do
          @user.last_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
        it '名（first_name）が空では登録できない' do
          @user.first_name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end
        it '姓（カナ）が空では登録できない' do
          @user.last_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank")
        end
        it '名（カナ）が空では登録できない' do
          @user.first_name_kana = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end
        it 'ニックネームが空では登録できない' do
          @user.nickname = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'メールアドレスが空では登録できない' do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'パスワードが空では登録できない' do
          @user.password = ""
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it '生年月日が空では登録できない' do
          @user.birth_date = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth date can't be blank")
        end
      end

      context 'パスワードに関するチェック' do
        it 'パスワードが数字だけでは登録できない' do
          @user.password = "123456"
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include("Password must be at least 6 characters and include both letters and numbers")
        end
        it 'パスワードが英語だけでは登録できない' do
          @user.password = "abcdef"
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include("Password must be at least 6 characters and include both letters and numbers")
        end
        it 'パスワードと確認用パスワードが一致しなければ登録できない' do
          @user.password = "test12"
          @user.password_confirmation = "different1"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'パスワードが5文字以下では登録できない' do
          @user.password = "1111a"
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
        end
      end

      context '名前に関するチェック' do
        it '姓（last_name）は全角でないと登録できない' do
          @user.last_name = "test"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name must be entered using full-width characters")
        end
        it '名（first_name）は全角でないと登録できない' do
          @user.first_name = "test"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name must be entered using full-width characters")
        end
        it '姓のフリガナ（last_name_kana）は全角カタカナでないと登録できない' do
          @user.last_name_kana = "ﾌﾘｶﾞﾅ"
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana must be entered using full-width katakana characters")
        end
        it '名のフリガナ（first_name_kana）は全角カタカナでないと登録できない' do
          @user.first_name_kana = "ﾌﾘｶﾞﾅ"
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana must be entered using full-width katakana characters")
        end
      end

      it 'メールアドレスに重複があっては登録できない' do
        @another_user = FactoryBot.create(:user)
        @user.email = @another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
    end
  end
end