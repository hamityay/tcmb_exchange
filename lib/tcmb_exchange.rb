require "tcmb_exchange/version"
require "open-uri"
require "nokogiri"

module TcmbExchange
  def self.get
    begin
      d = open("http://www.tcmb.gov.tr/kurlar/today.xml", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36")

      parsed = Nokogiri::XML(d.read, nil, "UTF-8")

      currency = Hash.new
      parsed.css("Currency").each do |c|
        name = c.css("Isim").to_s.gsub("/","").gsub("<Isim>","")
        next if name.include? "SDR"
        unit = c.css("Unit").to_s.gsub("/","").gsub("<Unit>","")
        al = c.css("ForexBuying").to_s.gsub("/","").gsub("<ForexBuying>","").to_f
        sat = c.css("ForexSelling").to_s.gsub("/","").gsub("<ForexSelling>","").to_f
        currency[name] = { "Birim" => unit, "Alış" => al, "Satış" => sat }
      end
      return currency
    rescue => error
      msg = "Hata oluştu. Lütfen github sayfasında, hangi durumda hatanın oluştuğunu belirten issue açınız."
      return error, msg
    end
  end

  def self.get_by_code(kod)
    kod.upcase!
    check = %w[USD AUD DKK EUR GBP CHF SEK CAD KWD NOK SAR JPY BGN RON RUB IRR CNY PKR QAR]
    return "Yanlış kod kullandınız." unless check.include? kod
    begin
      d = open("http://www.tcmb.gov.tr/kurlar/today.xml", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36")

      currency = Hash.new
      parsed = Nokogiri::XML(d.read, nil, "UTF-8")
      c = parsed.css("Currency[Kod=#{kod}]").first

      name = c.css("Isim").to_s.gsub("/","").gsub("<Isim>","")
      unit = c.css("Unit").to_s.gsub("/","").gsub("<Unit>","")
      al = c.css("ForexBuying").to_s.gsub("/","").gsub("<ForexBuying>","").to_f
      sat = c.css("ForexSelling").to_s.gsub("/","").gsub("<ForexSelling>","").to_f
      currency[name] = { "Birim" => unit, "Alış" => al, "Satış" => sat }
      return currency
    rescue => error
      msg = "Hata oluştu. Lütfen github sayfasında, hangi durumda hatanın oluştuğunu belirten issue açınız."
      return error, msg
    end
  end

  def self.exchange(kod, miktar)
    kod.upcase!
    check = %w[USD AUD DKK EUR GBP CHF SEK CAD KWD NOK SAR JPY BGN RON RUB IRR CNY PKR QAR]
    return "Yanlış kod kullandınız." unless check.include? kod
    miktar.to_s.gsub!(",",".") if miktar.to_s.include? ","
    begin
      miktar = Float(miktar)
    rescue => error
      return "Miktar sayı veya ondalıklı sayı olamalı."
    end

    begin
      d = open("http://www.tcmb.gov.tr/kurlar/today.xml", 'User-Agent' => "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36")

      currency = Hash.new
      parsed = Nokogiri::XML(d.read, nil, "UTF-8")
      c = parsed.css("Currency[Kod=#{kod}]").first

      name = c.css("Isim").to_s.gsub("/","").gsub("<Isim>","")
      unit = c.css("Unit").to_s.gsub("/","").gsub("<Unit>","")
      al = miktar / unit.to_i * (c.css("ForexBuying").to_s.gsub("/","").gsub("<ForexBuying>","").to_f)
      sat = miktar / unit.to_i * (c.css("ForexSelling").to_s.gsub("/","").gsub("<ForexSelling>","").to_f)
      currency[name] = { "Birim" => miktar, "Alış" => al, "Satış" => sat }
      return currency
    rescue => error
      msg = "Hata oluştu. Lütfen github sayfasında, hangi durumda hatanın oluştuğunu belirten issue açınız."
      return error, msg
    end
  end

end
