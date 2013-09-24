class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
  end


  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shop }
      else
        format.html { render action: 'new' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end
  
  def search
  	#検索範囲(km)
  	#@rng = params[:rng]
  	#経度
  	@lat = params[:latitude]
  	#緯度
  	@lng = params[:longitude]
  	
  	@shop_all = Shop.all
  	#範囲内の店舗情報取得
  	@shop = Shop.within(10,:origin => [@lat,@lng])
  	
  	#jsonへ書き出し
  	render:json => @shop
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :book_id, :latitude, :longitude, :open_time, :close_time, :address, :memo)
    end
end
