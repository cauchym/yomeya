require "open-uri"
require "rubygems"
require "nokogiri"
require 'mechanize'
require 'kconv'

def Stock_renewal(isbn)
	p "-------------------------------------------"
	shop_array = []
	url = "http://www.junkudo.co.jp/mj/products/list.php"
	agent = Mechanize.new
	page = agent.get(url)
	shop_name = ""
	
	agent.page.form_with(:id => 'mjSearchForm') {|f|
	  f['search_text'] = isbn.toutf8
	  f.click_button
	}
	agent.page.link_with(:text => "詳細".toutf8).click
	
	stock_url =  agent.page.uri
	stock_url = stock_url.to_s.sub("detail", "stock")
	
	page = agent.get(stock_url)
				
	agent.page.search('.table-mini td:first-child').each do |shop|
		shop_name = shop.text.strip
		if shop_name.include?(" ") 
			shop_name = shop_name.delete(" ")
		end
		if shop_name.include?("　") 
			shop_name = shop_name.delete("　")
		end
		
		shop = Shop.find_by name: shop_name
		shop_array.push shop.id
	end
	
	shop_str = shop_array.join(",")
		
	@book = Book.find_by isbn: isbn
	@book.shop_id = shop_str
	@book.save
	
# 	i = 0
# 	shop_text = ""
# 	while i < shop_array.length do
# 		shop_text = shop_text.to_s + shop_array.pop.to_s
# 	end 
# 	
# 	p shop_text
	
	
	
	p "-------------------------------------------"

end




class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: book_params }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
        Stock_renewal(book_params["isbn"])
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :image, :author, :isbn, :value, :wishlist_id, :shop_id)
    end
end
