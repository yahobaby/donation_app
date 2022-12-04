class DonationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  # index以外のアクションにおいて、ログインしていない場合はログインページに遷移するようにする。before_actionメソッドにauthenticate_user!を指定

  def index
  end

  def new
    @donation_address = DonationAddress.new
  end

  def create
    # binding.pry
    # @donation = Donation.create(donation_params)
    # Address.create(address_params)
    # redirect_to root_path

    @donation_address = DonationAddress.new(donation_params)
    if @donation_address.valid?
      # valid?メソッドを使用しているのは、DonationAddressクラスがApplicationRecordを継承していないことにより、saveメソッドにはバリデーションを実行する機能がないため
      @donation_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def donation_params
    # params.permit(:price).merge(user_id: current_user.id)
    params.require(:donation_address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :price).merge(user_id: current_user.id)
  end

  # def address_params
  #   params.permit(:postal_code, :prefecture, :city, :house_number, :building_name).merge(donation_id: @donation.id)
  #   # donation_idをmergeする
  #   # ※Addressモデルでは、Donationモデルへbelongs_toのアソシエーションを設定
  #   # つまり、addressesテーブルへ住所情報を保存するためには、どの寄付情報に紐づくのかを示すdonation_idが必要
  #   # したがって、13行目で先にdonationsテーブルへ保存し、25行目で保存済みのインスタンスのidを、donation_idの値として指定しています。
  # end
end
