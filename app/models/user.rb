class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :birth_date, presence: true
  validate :password_complexity
  validate :name_format_validation
  validate :name_kana_format_validation

  def password_complexity
    # Deviseのバリデーションがスキップされる場合や、パスワードが設定されていない場合はreturnを返してスキップ
    return if password.blank? || password =~ /\A(?=.*[a-z])(?=.*[0-9]).{6,}\z/i
    errors.add :password, 'must be at least 6 characters and include both letters and numbers'
  end

  def name_format_validation
    # 全角文字のみを許可
    full_width_regex = /\A[^\x01-\x7E]+\z/
    unless last_name =~ full_width_regex
      errors.add :last_name, 'must be entered using full-width characters'
    end
    unless first_name =~ full_width_regex
      errors.add :first_name, 'must be entered using full-width characters'
    end
  end

  def name_kana_format_validation
    # 全角カタカナのみを許可
    kana_regex = /\A[\p{katakana}ー－]+\z/
    unless last_name_kana =~ kana_regex
      errors.add :last_name_kana, 'must be entered using full-width katakana characters'
    end
    unless first_name_kana =~ kana_regex
      errors.add :first_name_kana, 'must be entered using full-width katakana characters'
    end
  end
end