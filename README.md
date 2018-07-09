# Tcmb Exchange

http://www.tcmb.gov.tr/kurlar/today.xml adresindeki verileri güncel olarak almanızı sağlar. Tüm Döviz kurlarını birden alabildiğiniz gibi istediğiniz döviz kurunu kodunu belirterek alabilirsiniz.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tcmb_exchange'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tcmb_exchange

## Usage

    $ require "tcmb_exchange"

Tüm döviz verilaerini almak için;

    $ result = TcmbExchange.get
```ruby
=>{"ABD DOLARI"=>{"Birim"=>"1", "Alış"=>4.5304, "Satış"=>4.5385}, "AVUSTRALYA DOLARI"=>{"Birim"=>"1", "Alış"=>3.378, "Satış"=>3.4}, "DANİMARKA KRONU"=>{"Birim"=>"1", "Alış"=>0.71444, "Satış"=>0.71795}, "EURO"=>{"Birim"=>"1", "Alış"=>5.3334, "Satış"=>5.343}, "İNGİLİZ STERLİNİ"=>{"Birim"=>"1", "Alış"=>6.0311, "Satış"=>6.0625}, "İSVİÇRE FRANGI"=>{"Birim"=>"1", "Alış"=>4.5774, "Satış"=>4.6068}, "İSVEÇ KRONU"=>{"Birim"=>"1", "Alış"=>0.51869, "Satış"=>0.52406}, "KANADA DOLARI"=>{"Birim"=>"1", "Alış"=>3.4588, "Satış"=>3.4744}, "KUVEYT DİNARI"=>{"Birim"=>"1", "Alış"=>14.8996, "Satış"=>15.0945}, "NORVEÇ KRONU"=>{"Birim"=>"1", "Alış"=>0.5649, "Satış"=>0.5687}, "SUUDİ ARABİSTAN RİYALİ"=>{"Birim"=>"1", "Alış"=>1.208, "Satış"=>1.2102}, "JAPON YENİ"=>{"Birim"=>"100", "Alış"=>4.0918, "Satış"=>4.1189}, "BULGAR LEVASI"=>{"Birim"=>"1", "Alış"=>2.7113, "Satış"=>2.7468}, "RUMEN LEYİ"=>{"Birim"=>"1", "Alış"=>1.1382, "Satış"=>1.1531}, "RUS RUBLESİ"=>{"Birim"=>"1", "Alış"=>0.07176, "Satış"=>0.0727}, "İRAN RİYALİ"=>{"Birim"=>"100", "Alış"=>0.01049, "Satış"=>0.01063}, "ÇİN YUANI"=>{"Birim"=>"1", "Alış"=>0.68067, "Satış"=>0.68958}, "PAKİSTAN RUPİSİ"=>{"Birim"=>"1", "Alış"=>0.03701, "Satış"=>0.03749}, "KATAR RİYALİ"=>{"Birim"=>"1", "Alış"=>1.2369, "Satış"=>1.2531}}
```    
```ruby
result.keys.each do |k|
  puts k
  br = result[k].keys.first
  al = result[k].keys[1]
  sat = result[k].keys.last
  puts "#{result[k][br]} birim " + k + " için alış: " + result[k][al].to_s + ", satış: " + result[k][sat].to_s + " TL."
end
```    
Belirli bir dövizi almak için;

    $ result = TcmbExchange.get_by_code "USD"
```ruby
    => {"ABD DOLARI"=>{"Birim"=>"1", "Alış"=>4.5304, "Satış"=>4.5385}}
```    

# Döviz Kodları :

1.  USD -> ABD DOLARI
2.  AUD -> AVUSTRALYA DOLARI
3.  DKK -> DANİMARKA KRONU
4.  EUR -> EURO
5.  GBP -> İNGİLİZ STERLİNİ
6.  CHF -> İSVİÇRE FRANGI
7.  SEK -> İSVEÇ KRONU
8.  CAD -> KANADA DOLARI
9.  KWD -> KUVEYT DİNARI
10. NOK -> NORVEÇ KRONU
11. SAR -> SUUDİ ARABİSTAN RİYALİ
12. JPY -> JAPON YENİ
13. BGN -> BULGAR LEVASI
14. RON -> RUMEN LEYİ
15. RUB -> RUS RUBLESİ
16. IRR -> İRAN RİYALİ
17. CNY -> ÇİN YUANI
18. PKR -> PAKİSTAN RUPİSİ
19. QAR -> KATAR RİYALİ

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hamityay/tcmb_exchange.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
