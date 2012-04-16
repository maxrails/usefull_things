require 'net/http'
require 'open-uri'
require 'nokogiri'

class ImageScraper
  EXTENSIONS = %w(jpg png psd tif jpeg gif bmp)

  def initialize(web_address,local_address)
    @web_address   = web_address
    @local_address = local_address
  end

  def grab
    @local_address = @local_address+'/'.gsub('//','/')
    Dir::mkdir(@local_address) unless File.directory? @local_address
    doc = Nokogiri::HTML(open(@web_address))
    @current_time = []
    doc.xpath('//img').each do |tt|
      image_address = tt['src'].gsub(@web_address,'')
      ext = get_ext(image_address,image_address.length)
      next if !EXTENSIONS.include?(ext)
      image_current_address = get_image_correct_path(image_address,@web_address)
      sleep(1) # this we need to ensure that we wouldn't have 2 files with same name end ext.
      @current_time << [Time.now.to_i,ext]
      open(@local_address+"#{@current_time.last[0]}."+ext, 'wb') do |file|
        file << open(image_current_address).read
      end
    end
    @current_time
  end

  def get_ext(image_address,length)
    ext = ''
    for i in 0..length do
      ext = image_address.strip[length-3-i..-1-i]
      break if EXTENSIONS.include?(ext)
    end
    ext
  end

  def get_image_correct_path(image_address,web_address)
    image_current_address = image_address.strip[0..2].include?('//') ? 'http:'+image_address : image_address
    image_current_address.include?('http://') || image_current_address.include?('https://') ? image_current_address : "#{web_address}#{image_address}"
  end

end
