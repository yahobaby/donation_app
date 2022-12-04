class DonationAddress #クラスを定義


# クラスにActiveModel::Modelをincludeすると、そのクラスのインスタンスはActiveRecordを継承したクラスのインスタンスと同様に form_with や render などのヘルパーメソッドの引数として扱え、バリデーションの機能を使用できるようにな流。
# Formオブジェクトパターンを実装するために「ActiveModel::Modelをincludeしたクラス」のことを「Formオブジェクト」と呼ぶ。
# DonationAddressクラスにActiveModel::Modelをinclude
# form_withメソッドに対応する機能とバリデーションを行う機能を、こちらの作成したクラスに持たせる為
  include ActiveModel::Model

  # 保存したいカラム名を属性値として扱えるようにする
  # DonationAddressクラス内でattr_accessorを使用
  ######## donationsテーブルとaddressesテーブルに保存したいカラム名を、すべて指定
  attr_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :price, :user_id


  # donationモデルとaddressモデルにあるバリデーションの記述を、Formオブジェクトへ移動
  with_options presence: true do
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: 'is invalid'}
    validates :user_id #user_idに対して、presence: trueのバリデーションを新たに追加
    # donationsテーブルに保存されるuser_idには、本来belongs_to :userのアソシエーションにより、バリデーションが設定されており、
    #Donationモデルがインスタンスを保存する際に紐付くユーザー情報がない場合、モデル内のアソシエーションの記述により保存できない。
    # しかし、donation_addressクラスにはアソシエーションを定義することはできず、belongs_toによるバリデーションを行うことができないので、
    # donation_addressクラスでuser_idに対してバリデーションを新たに設定
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
  # donationモデルとaddressモデルにあるバリデーションの記述を、Formオブジェクトへ移動
  

  # Formオブジェクトに、フォームから送られてきた情報をテーブルに保存する処理を記述
  def save
    # 寄付情報を保存し、変数donationに代入する
    donation = Donation.create(price: price, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, house_number: house_number, building_name: building_name, donation_id: donation.id)
  end
  # //Formオブジェクトに、フォームから送られてきた情報をテーブルに保存する処理を記述
  
end