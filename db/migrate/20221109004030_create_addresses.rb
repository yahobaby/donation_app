class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string     :postal_code,   null: false
      t.integer    :prefecture,    null: false
      t.string     :city
      t.string     :house_number
      t.string     :building_name
      t.references :donation,      null: false, foreign_key: true
      # 寄付をした人に送付する受領証明書は、donationsテーブルの情報に紐づくため、donation_idにはforeign_key: trueを指定
      t.timestamps
    end
  end
end
