class CreateDonations < ActiveRecord::Migration[6.0]
  def change
    create_table :donations do |t|
      t.integer    :price,   null: false, index: true
      t.references :user,    null: false, foreign_key: true
      # 寄付を行った人の情報は、usersテーブルの情報に紐づくため、user_id にはforeign_key: trueを指定
      t.timestamps
    end
  end
end
