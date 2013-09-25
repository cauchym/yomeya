# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# -*- coding: utf-8 -*-
require "open-uri"
require "rubygems"
require "nokogiri"
require 'mechanize'
require 'kconv'
require 'net/http'
require 'json'


def geocode(address)
   address = URI.encode(address)
   hash = Hash.new
   baseUrl = "http://maps.google.com/maps/api/geocode/json"
   reqUrl = "#{baseUrl}?address=#{address}&sensor=false&language=ja"
   response = Net::HTTP.get_response(URI.parse(reqUrl))
   status = JSON.parse(response.body)
   if status['results'][0]['geometry']['location']['lat'].present?
		hash['lat'] = status['results'][0]['geometry']['location']['lat']
		hash['lng'] = status['results'][0]['geometry']['location']['lng']
		return hash
	 else
	 	hash['lat'] = 0
	 	hash['lng'] = 0
	 	return hash
	 end
end

shops = Shop.all
if shops.blank?
	Shop.create(:name => "MARUZEN&ジュンク堂書店札幌店",:latitude => 43.075059,:longitude => 141.3493,:address => "札幌市中央区南1条西1丁目8-2丸井今井南館B2F-5F ")
	Shop.create(:name => "MARUZEN札幌北一条店",:latitude => 43.061889,:longitude => 141.35225,:address => "札幌市中央区北1条西3丁目2番井門札幌ビル1階 ")
	Shop.create(:name => "MARUZEN旭川店（文具専門）",:latitude => 43.765709,:longitude => 142.359958,:address => "旭川市一条通8丁目108番フィール旭川5F ")
	Shop.create(:name => "ジュンク堂書店旭川店",:latitude => 43.765627,:longitude => 142.359906,:address => "北海道旭川市一条通8丁目108番フィール旭川1～5F ")
	Shop.create(:name => "MARUZEN弘前中三店（文具専門）",:latitude => 40.601922,:longitude => 140.473107,:address => "弘前市土手町49-1中三百貨店　6F・7F ")
	Shop.create(:name => "ジュンク堂書店弘前中三店",:latitude => 40.601922,:longitude => 140.473107,:address => "弘前市土手町49-1中三百貨店　6F・7F ")
	Shop.create(:name => "MARUZEN盛岡店(文具)",:latitude => 39.703155,:longitude => 141.144832,:address => "盛岡市大通2丁目8-14 MOSSﾋﾞﾙ2F ")
	Shop.create(:name => "ジュンク堂書店盛岡店",:latitude => 39.703098,:longitude => 141.144669,:address => "盛岡市大通2-8-14MOSSビル3F・4F (Junku.COM 併設) ")
	Shop.create(:name => "丸善仙台アエル店",:latitude => 38.261605,:longitude => 140.881629,:address => "仙台市青葉区中央1-3-1AER1階 ")
	Shop.create(:name => "MARUZEN仙台イービーンズ店(文具専門)",:latitude => 38.259438,:longitude => 140.880038,:address => "仙台市青葉区中央4-1-1仙台イービーンズ 3F ")
	Shop.create(:name => "ジュンク堂書店仙台本店",:latitude => 38.259438,:longitude => 140.880233,:address => "仙台市青葉区中央4-1-1仙台イービーンズ 3・5・6・7F ")
	Shop.create(:name => "ジュンク堂書店仙台ロフト店",:latitude => 38.260168,:longitude => 140.88056,:address => "仙台市青葉区中央1-10-10仙台ロフト7F ")
	Shop.create(:name => "ジュンク堂書店仙台TR店",:latitude => 38.260612,:longitude => 140.880454,:address => "仙台市青葉区中央3-6-1仙台TRビルB1F ")
	Shop.create(:name => "ジュンク堂書店秋田店",:latitude => 39.717868,:longitude => 140.128176,:address => "秋田市千秋久保田町4-2秋田フォーラス6F・7F (Junku.COM 併設) ")
	Shop.create(:name => "MARUZEN郡山店（文具専門）",:latitude => 37.396549,:longitude => 140.384398,:address => "郡山市中町13-1うすい百貨店8階 ")
	Shop.create(:name => "ジュンク堂書店郡山店",:latitude => 37.396467,:longitude => 140.384483,:address => "郡山市中町13-1うすい百貨店9F ")
	Shop.create(:name => "丸善水戸京成店",:latitude => 36.377912,:longitude => 140.464281,:address => "水戸市泉町1-6-1京成百貨店8階 ")
	Shop.create(:name => "丸善水戸エクセル店（文具専門）",:latitude => 36.370695,:longitude => 140.477306,:address => "水戸市宮町1-1-1水戸駅ビルエクセル5階 ")
	Shop.create(:name => "丸善そごう川口店",:latitude => 35.802956,:longitude => 139.718654,:address => "川口市栄町3-5-1そごう川口店9階 ")
	Shop.create(:name => "丸善プレス・アミワカバウォーク店（文具専門）",:latitude => 35.949191,:longitude => 139.410946,:address => "鶴ヶ島市富士1-2-1ワカバウォーク１階 B-1-8a区画 ")
	Shop.create(:name => "丸善川越丸広店（文具専門）",:latitude => 35.939838,:longitude => 139.441628,:address => "川越市新富町2-6-1丸広百貨店川越店別館2階 ")
	Shop.create(:name => "MARUZEN丸広百貨店飯能店",:latitude => 35.853049,:longitude => 139.326414,:address => "飯能市栄町24－4丸広百貨店飯能店6階 ")
	Shop.create(:name => "ジュンク堂書店大宮高島屋店",:latitude => 35.914096,:longitude => 139.62713,:address => "さいたま市大宮区大門町1-32大宮高島屋ビル7F ")
	Shop.create(:name => "丸善津田沼店",:latitude => 35.690773,:longitude => 140.01861,:address => "習志野市谷津7-7-1ブロックＢ棟2・3階 ")
	Shop.create(:name => "丸善舞浜イクスピアリ店",:latitude => 35.634688,:longitude => 139.885167,:address => "浦安市舞浜1-4イクスピアリ内101 ")
	Shop.create(:name => "MARUZEN松戸伊勢丹店（文具）",:latitude => 35.782182,:longitude => 139.898722,:address => "松戸市松戸1307-1伊勢丹松戸店8階 ")
	Shop.create(:name => "ジュンク堂書店松戸伊勢丹店",:latitude => 35.782597,:longitude => 139.899171,:address => "松戸市松戸1307-1松戸伊勢丹店8Ｆ ")
	Shop.create(:name => "MARUZEN&ジュンク堂書店渋谷店",:latitude => 35.660617,:longitude => 139.696083,:address => "渋谷区道玄坂2-24-1東急百貨店7F ")
	Shop.create(:name => "丸善丸の内本店",:latitude => 35.641478,:longitude => 139.675931,:address => "千代田区丸の内1-6-4 丸の内オアゾショップ&レストラン1～4階 ")
	Shop.create(:name => "丸善日本橋店",:latitude => 35.681155,:longitude => 139.772517,:address => "中央区日本橋2-3-10 ")
	Shop.create(:name => "丸善お茶の水店",:latitude => 35.699288,:longitude => 139.76429,:address => "千代田区神田駿河台2-8瀬川ビル1階 ")
	Shop.create(:name => "MARUZEN多摩センター店",:latitude => 35.622493,:longitude => 139.424839,:address => "多摩市落合1－46－1ココリア多摩センター5階 ")
	Shop.create(:name => "丸善アークヒルズ店",:latitude => 35.667729,:longitude => 139.740048,:address => "港区赤坂1-12-32アーク森ビル3階 ")
	Shop.create(:name => "丸善有明ワンザ店",:latitude => 35.63068,:longitude => 139.790012,:address => "江東区有明三丁目6-11東京ファッションタウンビル東館2階 ")
	Shop.create(:name => "丸善メトロ・エム後楽園店",:latitude => 35.707239,:longitude => 139.751318,:address => "文京区春日1-2-3メトロ・エム後楽園3階 ")
	Shop.create(:name => "丸善アトレ大森店（文具専門）",:latitude => 35.588454,:longitude => 139.728434,:address => "大田区大森北1-6-16アトレ大森4階 ")
	Shop.create(:name => "丸善新宿京王店（文具専門）",:latitude => 35.690544,:longitude => 139.699373,:address => "新宿区西新宿1-1-4京王百貨店新宿店7階 ")
	Shop.create(:name => "丸善アトレ吉祥寺店（文具専門）",:latitude => 35.70305,:longitude => 139.579548,:address => "武蔵野市吉祥寺南町1-1-24 ")
	Shop.create(:name => "丸善府中伊勢丹店（文具専門）",:latitude => 35.670814,:longitude => 139.479814,:address => "府中市宮町1-41-2伊勢丹府中店7階 ")
	Shop.create(:name => "丸善パピエ田無店（文具専門）",:latitude => 35.72851,:longitude => 139.540363,:address => "西東京市田無町2-1-1ASTA（アスタ）ビル3階 ")
	Shop.create(:name => "丸善立川伊勢丹店（文具専門）",:latitude => 35.699549,:longitude => 139.412957,:address => "立川市曙町2-5-1伊勢丹立川店6階 ")
	Shop.create(:name => "ジュンク堂書店池袋本店",:latitude => 35.726837,:longitude => 139.712389,:address => "豊島区南池袋2-15-5 ")
	Shop.create(:name => "ジュンク堂書店プレスセンター店",:latitude => 35.670988,:longitude => 139.754267,:address => "千代田区内幸町2-2-1日本プレスセンタービル1F ")
	Shop.create(:name => "ジュンク堂書店吉祥寺店",:latitude => 35.705088,:longitude => 139.579648,:address => "武蔵野市吉祥寺本町1-11-5コピス吉祥寺B館　6F・7F ")
	Shop.create(:name => "丸善ラゾーナ川崎店",:latitude => 35.533095,:longitude => 139.695883,:address => "川崎市幸区堀川町72-1ラゾーナ川崎プラザ1階 ")
	Shop.create(:name => "丸善横浜ポルタ店",:latitude => 35.465033,:longitude => 139.623209,:address => "横浜市西区高島2-16横浜駅東口ポルタ下街B1-211号 ")
	Shop.create(:name => "ジュンク堂書店藤沢店",:latitude => 35.339887,:longitude => 139.488253,:address => "藤沢市藤沢559ビックカメラ藤沢店7F・8F ")
	Shop.create(:name => "MARUZEN新潟店(文具)",:latitude => 37.910582,:longitude => 139.064026,:address => "新潟県新潟市中央区笹口一丁目一番プラーカ１　１階・階　（JR新潟駅南口） ")
	Shop.create(:name => "ジュンク堂書店新潟店",:latitude => 37.909447,:longitude => 139.063635,:address => "新潟市中央区笹口1-1プラーカ１ １階・階　（JR新潟駅南口） (Junku.COM 併設) ")
	Shop.create(:name => "MARUZEN岡島甲府店（文具専門）",:latitude => 35.661775,:longitude => 138.570481,:address => "甲府市丸の内1-21-15岡島百貨店 6F ")
	Shop.create(:name => "ジュンク堂書店岡島甲府店",:latitude => 35.661775,:longitude => 138.570481,:address => "甲府市丸の内1-21-15岡島百貨店 6F ")
	Shop.create(:name => "MARUZEN松本店",:latitude => 36.229672,:longitude => 137.967302,:address => "松本市深志1丁目3－11コングロM　B1・1階・2階 ")
	Shop.create(:name => "MARUZEN&ジュンク堂書店新静岡店",:latitude => 34.975499,:longitude => 138.38699,:address => "静岡市葵区鷹匠1丁目1番1号新静岡セノバ5階 ")
	Shop.create(:name => "MARUZEN名古屋栄店",:latitude => 35.168362,:longitude => 136.905415,:address => "名古屋市中区栄三丁目3番1号丸栄6・7階 ")
	Shop.create(:name => "丸善名古屋セントラルパーク店",:latitude => 35.171317,:longitude => 136.907506,:address => "名古屋市中区錦3-15-13セントラルパーク下街 ")
	Shop.create(:name => "丸善名古屋松坂屋店",:latitude => 35.166233,:longitude => 136.908068,:address => "名古屋市中区栄3-16-1松坂屋名古屋北館２F ")
	Shop.create(:name => "ジュンク堂書店ロフト名古屋店",:latitude => 35.166955,:longitude => 136.905259,:address => "名古屋市中区栄3-18-1ナディアパークB1F・7F ")
	Shop.create(:name => "ジュンク堂書店名古屋店",:latitude => 35.172049,:longitude => 136.886241,:address => "名古屋市中村区名駅3-25-9堀内ビル1F ")
	Shop.create(:name => "MARUZEN四日市店",:latitude => 34.967204,:longitude => 136.619056,:address => "四日市市諏訪栄町7－34近鉄百貨店四日市店階 ")
	Shop.create(:name => "丸善京都四条烏丸店（文具専門）",:latitude => 35.00405,:longitude => 135.759268,:address => "京都市下京区四条通室町東入函谷鉾町101ラクエ四条烏丸3F ")
	Shop.create(:name => "ジュンク堂書店京都店",:latitude => 34.99592,:longitude => 135.754937,:address => "京都市下京区四条通柳馬場東入ル立売東町20-1 ")
	Shop.create(:name => "ジュンク堂書店京都朝日会館店",:latitude => 35.023153,:longitude => 135.768528,:address => "京都市中京区河原町通三条上恵比須町427京都朝日会館3階4階 ")
	Shop.create(:name => "MARUZEN&ジュンク堂書店梅田店",:latitude => 34.707456,:longitude => 135.500218,:address => "大阪市北区茶屋町7-20チャスカ茶屋町 下1階～7階 ")
	Shop.create(:name => "丸善関西国際空港店",:latitude => 34.43354,:longitude => 135.237819,:address => "泉南郡田尻町泉州空港中1番旅客ターミナル3階 ")
	Shop.create(:name => "丸善八尾アリオ店",:latitude => 34.632607,:longitude => 135.605868,:address => "八尾市光町2-3アリオ八尾3階 ")
	Shop.create(:name => "ジュンク堂書店大阪本店",:latitude => 34.696904,:longitude => 135.496397,:address => "大阪市北区堂島1-6-20堂島アバンザ1F～3F ")
	Shop.create(:name => "ジュンク堂書店難波店",:latitude => 34.666715,:longitude => 135.496176,:address => "大阪市浪速区湊町1-2-3マルイト難波ビル3F ")
	Shop.create(:name => "ジュンク堂書店千日前店",:latitude => 34.664624,:longitude => 135.503074,:address => "大阪市中央区難波千日前12-7Y.E.S.NAMBAビル1F～3F ")
	Shop.create(:name => "ジュンク堂書店天満橋店",:latitude => 34.690134,:longitude => 135.516431,:address => "大阪市中央区天満橋京町1-1京阪シティモール7F ")
	Shop.create(:name => "ジュンク堂書店上本町店",:latitude => 34.665594,:longitude => 135.519746,:address => "大阪市天王寺区上本町6－1－55近鉄百貨店11階 ")
	Shop.create(:name => "COMICSJUNKUDO難波店",:latitude => 34.666587,:longitude => 135.495292,:address => "大阪市浪速区湊町1丁目4番1号OCATビル5階 ")
	Shop.create(:name => "ジュンク堂書店梅田ヒルトンプラザ店",:latitude => 34.700449,:longitude => 135.496249,:address => "大阪市北区梅田1丁目8-16ヒルトンプラザイースト5F ")
	Shop.create(:name => "ジュンク堂書店三宮店",:latitude => 34.691241,:longitude => 135.192539,:address => "神戸市中央区三宮町1-6-18 ")
	Shop.create(:name => "ジュンク堂書店西宮店",:latitude => 34.747356,:longitude => 135.357352,:address => "西宮市北口町1-1アクタ西宮西館4F ")
	Shop.create(:name => "ジュンク堂書店神戸住吉店",:latitude => 34.719824,:longitude => 135.262003,:address => "神戸市東灘区住吉本町1-2-1住吉ターミナルビル4F ")
	Shop.create(:name => "ジュンク堂書店芦屋店",:latitude => 34.735087,:longitude => 135.30771,:address => "芦屋市大原町9-1-304ラポルテ東館3F ")
	Shop.create(:name => "ジュンク堂書店三宮駅前店",:latitude => 34.695066,:longitude => 135.196525,:address => "神戸市中央区雲井通6-1-15サンシティビル7F・8F (漫画館 併設) ")
	Shop.create(:name => "ジュンク堂書店明石店（9/30閉店）",:latitude => 34.647958,:longitude => 134.99224,:address => "明石市大明石町1-6-7明神ビル Ｂ1・1・2Ｆ ")
	Shop.create(:name => "ジュンク堂書店姫路店",:latitude => 34.826464,:longitude => 134.689122,:address => "姫路市豆腐町222ピオレ姫路ヤング館２Ｆ ")
	Shop.create(:name => "ジュンク堂書店舞子店",:latitude => 34.635136,:longitude => 135.033948,:address => "神戸市垂水区東舞子町10-1-301Ｔｉｏ舞子3F ")
	Shop.create(:name => "丸善岡山シンフォニービル店",:latitude => 34.662113,:longitude => 133.926182,:address => "岡山市北区表町1-5-1岡山シンフォニービル下1階 ")
	Shop.create(:name => "ジュンク堂書店岡山店",:latitude => 34.661815,:longitude => 133.919833,:address => "岡山市北区幸町7-6岡山ビブレA館2F・3F ")
	Shop.create(:name => "MARUZEN広島店",:latitude => 34.39324,:longitude => 132.463788,:address => "広島市中区胡町5-22天満屋八丁堀ビル7・8F ")
	Shop.create(:name => "ジュンク堂書店広島駅前店",:latitude => 34.396426,:longitude => 132.473839,:address => "広島市南区松原町9-1福屋広島駅前店10F ")
	Shop.create(:name => "ジュンク堂書店松山店",:latitude => 33.836971,:longitude => 132.76444,:address => "松山市千舟町5-7-1エスパス松山ビル ")
	Shop.create(:name => "丸善博多店",:latitude => 33.589308,:longitude => 130.420591,:address => "福岡市博多区博多駅中央街1番1号JR博多シティ8F ")
	Shop.create(:name => "MARUZEN福岡店(文具)",:latitude => 33.590902,:longitude => 130.400677,:address => "福岡市中央区天神1-10-13天神MMTビルB1F ")
	Shop.create(:name => "ジュンク堂書店福岡店",:latitude => 33.59083,:longitude => 130.400585,:address => "福岡市中央区天神1-10-13メディアモール天神B1F～4F ")
	Shop.create(:name => "ジュンク堂書店大分店",:latitude => 33.235992,:longitude => 131.606873,:address => "大分市中央町1-2-7大分フォーラス7F・8F (Junku.COM 併設) ")
	Shop.create(:name => "MARUZEN天文館店",:latitude => 31.591869,:longitude => 130.555739,:address => "鹿児島市中町3-15ヴィストラルビルB3F～6F ")
	Shop.create(:name => "ジュンク堂書店鹿児島店",:latitude => 31.59097,:longitude => 130.556974,:address => "鹿児島市呉服町6-5マルヤガーデンズ5F・6F ")
	Shop.create(:name => "ジュンク堂書店那覇店",:latitude => 26.219298,:longitude => 127.68707,:address => "那覇市牧志1-19-29D-NAHA1F-3F ")
	Shop.create(:name => "淳久堂台北忠孝店",:latitude => 25.041886,:longitude => 121.545006,:address => "台北市忠孝東路四段４５號太平洋SOGO忠孝館10F ")
	Shop.create(:name => "淳久堂台北天母店",:latitude => 25.104745,:longitude => 121.524536,:address => "台北市中山北路六段７７號太平洋SOGO天母店７F ")
end

# shops = Shop.all
# if shops.blank?
# 	# -------------------------------
# 	# shoplistのスクレイピング
# 	# -------------------------------
# 	url = "http://www.junkudo.co.jp/mj/store/store_search.php"
# 	name_array = []
# 	address_array = []
# 	
# 	agent = Mechanize.new
# 	page = agent.get(url)
# 	
# 	agent.page.search('.table td > a').each do |link|
# 	
# 		agent.page.link_with(:text => link.text.toutf8).click
# 	
# 		shop_name = agent.page.at('.store_description h3').text.strip
# 		if shop_name.include?(" ") 
# 			shop_name = shop_name.delete(" ")
# 		end
# 		if shop_name.include?("　") 
# 			shop_name = shop_name.delete("　")
# 		end
# 		
# 	# 	puts name
# 		
# 		tel = agent.page.at('.store_description h4').text.strip
# 		if tel.include?("TEL.") 
# 			tel = tel.delete("TEL.")
# 		end
# 	# 	puts tel
# 		
# 		shop_address = agent.page.at('.store_description p').text.strip
# 		if shop_address.include?("地図を見る") 
# 			shop_address = shop_address.delete("地図を見る")
# 		end
# 	# 	puts address
# 		
# # 		shop_geo = geocode(shop_address)
# 		
# 		open_time = agent.page.at('.store_description h5 span').text.strip
# 	# 	puts open_time
# 		
# 		closed_day = agent.page.at('.store_description h5 span:nth-child(5)').text.strip
# 	# 	puts closed_day
# 		
# 		page = agent.get(url)
# 		
# 	# 	puts("----------------------------------")
# 	
# 		Shop.create(:name => shop_name,:latitude => 0,:longitude => 0,:address => shop_address)	
# 
# # 		Shop.create(:name => shop_name,:latitude => shop_geo['lat'],:longitude => shop_geo['lng'],:address => shop_address)	
# 	
# 
# 	end
# 	# -------------------------------
# 	# 終わり
# 	# -------------------------------
# end
# shops = Shop.all

