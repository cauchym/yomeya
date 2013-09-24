require "open-uri"
require "rubygems"
require "nokogiri"
require 'mechanize'
require 'kconv'

def wishlist_scraping(r_url)
	num = 1
	page_num = 1
	
	agent = Mechanize.new
	
	
	while num < page_num + 1 do
	
		url = r_url + "/ref=cm_wl_sortbar_v_page_" + num.to_s + "??_encoding=UTF8&filter=3&layout=standard&page=" + num.to_s + "&reveal=unpurchased&sort=date-added"
		html = open(url).read		
		html = html.sub(/^<!DOCTYPE html(.*)$/, '<!DOCTYPE html>')
		
		doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
		
		page_num = doc.css('.num-pages').text.to_i
		
		out_title = ""
		out_image = ""
		out_author = ""
		out_isbn = ""
		out_price = 0

		doc.css('.itemWrapper').each do |itemWrapper|
			itemWrapper.css('span.authorPart').each do |author|
			  if author.next != nil
			  	if author.next.text.strip.include?("(")
			  		itemWrapper.css('.productTitle > strong > a').each do |title|
							
							out_title = ""
							out_image = ""
							out_author = ""
							out_isbn = ""
							out_price = 0

							# タイトル出力
						  out_title = title.text.strip.to_s
		
							# -------------------------------
							# 各本のページからISBNコードを取得 
							# -------------------------------					
						  url_isbn = title.attribute("href").text
						  if url_isbn.include?("‾") 
								url_isbn = url_isbn.delete("‾")
							end
							page = agent.get(url_isbn)
							
							agent.page.search('h2').each do |h2_isbn|
								if h2_isbn.text.strip == "登録情報"
									h2_isbn.parent.css('li > b').each do |content|
										if content.text.strip == "ISBN-13:"
											# ISBN出力
											out_isbn = content.next.text.strip.to_s
										end
									end
								end
							end
							# -------------------------------
							# 終わり
							# -------------------------------
											
						end
						
			  		
			  		# 著者出力
			  		out_author = author.text.strip
			  		# 本の型出力
			  		# puts author.next.text.strip
						
						itemWrapper.css('.productImage > a > img').each do |image|
						  # 本の画像のURL出力
						  out_image = image.attribute("src").to_s
						end
			  		
			  		itemWrapper.css('span.wlPriceBold').each do |price|					  
						  # 本の価格出力
						  out_price = price.text.strip.to_s
						  if out_price.include?("¥")
								out_price = out_price.delete("¥")
							end
							if out_price.include?(",")
								out_price = out_price.delete(",")
							end
							out_price = out_price.to_i
						  
						end
						if out_isbn.present? 
							Book.create(:title => out_title,:image => out_image,:author => out_author,:isbn => out_isbn,:value => out_price)	
			  		end
			  	end
			  end
			end
		end
		num += 1;
	end


#	p @book_id
#	p "###########################################################################"
	concat_str = @book_id.join(",")
	# @book_id.each do |id|
	# 	concat_str += (id.to_s + ",")
	# 	p concat_str
	# end

#	p Wishlist.column_names
#	p url
	@wishlist = Wishlist.where(:url => r_url).first
#	p @wishlist.inspect
    if !@wishlist
		@wishlist = Wishlist.new
	end
	@wishlist.book_id = concat_str
	@wishlist.save
end

class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]

  # GET /wishlists
  # GET /wishlists.json
  def index
    @wishlists = Wishlist.all
  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new
  end

  # GET /wishlists/1/edit
  def edit
  end

  # POST /wishlists
  # POST /wishlists.json
  def create
    @wishlist = Wishlist.new(wishlist_params)

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wishlist }
        wishlist_scraping(wishlist_params["url"])
      else
        format.html { render action: 'new' }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlists/1
  # PATCH/PUT /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.require(:wishlist).permit(:url, :scrape_status, :name, :book_id, :shop_id, :notice, :distance)
    end
end
