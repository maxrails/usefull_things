#!/usr/bin/env ruby
#This is a script that we can start like ./grab.rb 'http://www.example.com' 'local_path_where_to_store_images' - it grab all images from site.
EXTENSIONS = %w(jpg png psd tif jpeg gif bmp)

begin
  require 'net/http'
  require 'open-uri'
  require 'nokogiri'

  web_address   = ARGV[0]
  local_address = ARGV[1]

  local_address = local_address+'/'.gsub('//','/')

  doc = Nokogiri::HTML(open(web_address))
  p doc.inspect
  doc.xpath('//img').each do |tt|
    image_address = tt['src'].gsub(web_address,'')
    p "IMAGE = #{image_address}"
    length = image_address.length
    for i in 0..length do
      ext = image_address.strip[length-3-i..-1-i]
      p ext
      break if EXTENSIONS.include?(ext)
    end
    next if !EXTENSIONS.include?(ext)
    p local_address+"#{Time.now.to_i}."+ext
    image_current_address = image_address.include?('http://') ? image_address : "#{web_address}#{image_address}"
    image_current_address = image_current_address.strip[0..2] == '//' ? 'http:'+image_current_address : image_current_address
    open(local_address+"#{Time.now.to_i}."+ext, 'wb') do |file|
      file << open(image_current_address).read rescue nil
    end
  end

end
