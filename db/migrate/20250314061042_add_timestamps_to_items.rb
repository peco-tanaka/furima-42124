class AddTimestampsToItems < ActiveRecord::Migration[6.0]
  def change
    # 現在のタイムスタンプを取得
    current_time = Time.current

    # カラムを追加（文字列の形でデフォルト値を指定
    add_column :items, :created_at, :datetime, null: false, default: current_time
    add_column :items, :updated_at, :datetime, null: false, default: current_time

    # 必要に応じて後でデフォルト値を削除
    # change_column_default :items, :created_at, nil
    # change_column_default :items, :updated_at, nil
  end
end
