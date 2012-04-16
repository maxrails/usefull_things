require 'spec_helper'

describe ImageScraper do
  before :each do
    @web_site1 = 'spec/data/RSpec.info_home.html'
    @web_site2 = 'spec/data/facebook.html'
    @scraper1 = ImageScraper.new(@web_site1,'spec/data/images/')
    @scraper2 = ImageScraper.new(@web_site2,'spec/data/images/')
  end

  it "grab image from sites" do
    # grab images from rspec home page
    time_created = @scraper1.grab
    absolute_path = File.absolute_path("spec/data/images/#{time_created.last[0]}.#{time_created.last[1]}").gsub("spec/data/images/#{time_created.last[0]}.#{time_created.last[1]}",'')
    File.exist?("spec/data/images/#{time_created.last[0]}.#{time_created.last[1]}").should == true

    # grab images from facebook login page
    time_created = @scraper2.grab
    time_created.each_with_index{|item,index| File.exist?(absolute_path+"spec/data/#{item[0]}.#{item[1]}")}

    # remove directory with images
    FileUtils.rm_rf("#{absolute_path}spec/data/images/")
  end

end  
