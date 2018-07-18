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

  def self.exchange_to(miktar, kod, kod2)
    kod.upcase!
    kod2.upcase!
    check = %w[USD AUD DKK EUR GBP CHF SEK CAD KWD NOK SAR JPY BGN RON RUB IRR CNY PKR QAR]
    return "Yanlış kod kullandınız." unless check.include?(kod) and check.include?(kod2)
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
      code = c.css("CurrencyCode").to_s.gsub("/","").gsub("<CurrencyCode>","")
      unit = c.css("Unit").to_s.gsub("/","").gsub("<Unit>","")
      al = miktar / unit.to_i * (c.css("ForexBuying").to_s.gsub("/","").gsub("<ForexBuying>","").to_f)
      sat = miktar / unit.to_i * (c.css("ForexSelling").to_s.gsub("/","").gsub("<ForexSelling>","").to_f)

      c2 = parsed.css("Currency[Kod=#{kod2}]").first
      name2 = c2.css("Isim").to_s.gsub("/","").gsub("<Isim>","")
      code2 = c2.css("CurrencyCode").to_s.gsub("/","").gsub("<CurrencyCode>","")
      unit2 = c2.css("Unit").to_s.gsub("/","").gsub("<Unit>","")
      al2 = (c2.css("ForexBuying").to_s.gsub("/","").gsub("<ForexBuying>","").to_f) / unit2.to_i
      sat2 = (c2.css("ForexSelling").to_s.gsub("/","").gsub("<ForexSelling>","").to_f) / unit2.to_i

      al = al / al2
      sat = sat / sat2

      currency[name] = { "Birim" => miktar, "Alış" => al, "Satış" => sat, "Sonuç" => "#{miktar} #{name} için alış fiyatı #{al} #{name2}, satış fiyatı #{sat} #{name2}." }

      return currency
    rescue => error
      msg = "Hata oluştu. Lütfen github sayfasında, hangi durumda hatanın oluştuğunu belirten issue açınız."
      return error, msg
    end
  end

end
