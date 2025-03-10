# DB設計

## usersテーブル
| Column          | Type    | Options                   |
|-----------------|---------|---------------------------|
| last_name       | string  | null: false               |
| first_name      | string  | null: false               |
| last_name_kana  | string  | null: false               |
| first_name_kana | string  | null: false               |
| nickname        | string  | null: false               |
| email           | string  | null: false, unique: true |
| password        | string  | null: false               |
| birth_date      | date    | null: false               |
| created_at      | datetime| null: false               |
| updated_at      | datetime| null: false               |

### Association
- has_many :items
- has_many :orders
- has_many :comments

## itemsテーブル
| Column               | Type    | Options                        |
|----------------------|---------|--------------------------------|
| name                 | string  | null: false                    |
| description          | text    | null: false                    |
| condition_id         | integer | null: false                    |
| price                | integer | null: false                    |
| shipping_fee_status  | integer | null: false                    |
| shipping_day_id      | integer | null: false                    |
| sender_prefecture_id | integer | null: false                    |
| category_id          | integer | null: false                    |
| created_at           | datetime| null: false                    |
| updated_at           | datetime| null: false                    |
| user_id              | integer | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order
- has_many :comments
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping_day
- belongs_to_active_hash :category
- belongs_to_active_hash :prefecture, foreign_key: 'sender_prefecture_id'

#### 備考
- 商品画像はActive Storageを使用して管理

## ordersテーブル
| Column               | Type    | Options                        |
|----------------------|---------|--------------------------------|
| created_at           | datetime| null: false                    |
| updated_at           | datetime| null: false                    |
| user_id              | integer | null: false, foreign_key: true |
| item_id              | integer | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :delivery_address

## commentsテーブル
| Column      | Type    | Options                        |
|-------------|---------|--------------------------------|
| content     | text    | null: false                    |
| created_at  | datetime| null: false                    |
| updated_at  | datetime| null: false                    |
| user_id     | integer | null: false, foreign_key: true |
| item_id     | integer | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## delivery_addressesテーブル
| Column        | Type    | Options                        |
|---------------|---------|--------------------------------|
| postal_code   | string  | null: false                    |
| prefecture_id | integer | null: false                    |
| city          | string  | null: false                    |
| address       | string  | null: false                    |
| building_name | string  |                                |
| phone_number  | string  | null: false                    |
| created_at    | datetime| null: false                    |
| updated_at    | datetime| null: false                    |
| order_id      | integer | null: false, foreign_key: true |

### Association
- belongs_to :order