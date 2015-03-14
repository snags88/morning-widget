require 'open-uri'

class MTA
  URL = "http://web.mta.info/status/serviceStatus.txt"
  LINES = ["123","456","7","ACE","BDFM","G", "JZ", "L", "NQR", "S"]

  attr_accessor :doc, :status_hash

  def initialize
    @doc = Nokogiri::XML(open(URL))
    self.status_hash = Hash.new
    scrape_status
  end

  def status(line)
    return_hash = Hash.new
    if line.empty?
      return_hash = status_hash
    else
      line.each do |line_key|
       return_hash[line_key] = self.status_hash[line_key]
      end
    end
    return_hash
  end

  def scrape_status
    @doc.search("subway line").each do |line|
      self.status_hash[line.search("name").text] = {
      "status" => line.search("status").text,
      "text" => text_parser(line.search("text").text)
      }
    end
  end

  def text_parser(text)
    status_collection = Nokogiri::HTML(text)
    status_array = status_collection.search("p").collect{|status| status.text.strip}
    status_array.delete("Allow additional travel time.")
    status_array
  end

  def status_time
    @doc.css("timestamp").text
  end

end

=begin
 status_hash = { "123" => {"status" => "",
                           "text" => ""},
                "456" => {"status" => "",
                           "text" => ""}
}


=end