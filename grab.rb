#!/usr/bin/env ruby
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
    ext = image_address[length-3]+image_address[length-2]+image_address[length-1]
    open(local_address+"#{Time.now.to_i}."+ext, 'wb') do |file|
      file << open("#{web_address}#{image_address}").read
    end

  end

end  
