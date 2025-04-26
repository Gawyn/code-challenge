require 'nokolexbor'
require 'open-uri'
require 'selenium-webdriver'

class GoogleSearchArtworksParser
  def self.parse(location)
    driver.navigate.to process_location(location)
    doc = Nokolexbor::HTML(driver.page_source)
    objects = doc.css(".iELo6")

    {"artworks" => process_objects(objects)}
  end

  private

  def self.driver
    @driver ||= Selenium::WebDriver.for :chrome
  end

  def self.process_location(location)
    if url?(location)
      location
    else
      "File://" + Dir.pwd + "/" + location
    end
  end

  def self.process_objects(objects)
    objects.map { |o| process_object(o) }
  end

  def self.process_object(object)
    link_object = object.css('a').first

    {
      "link" => "https://www.google.com" + link_object['href'],
      "name" => link_object.css('.pgNMRc').first.content,
    }.tap do |h|
      h["image"] = get_image(link_object)

      extensions = object.css('.cxzHyb').first.content
      h['extensions'] = [extensions] if extensions && extensions != ''
    end
  end
  
  def self.get_image(link_object)
    link_object.css('img').first['data-src'] || link_object.css('img').first['src']
  end

  def self.url?(string)
    uri = URI.parse(string)
    uri.scheme && uri.host
  rescue URI::InvalidURIError
      false
  end
end
