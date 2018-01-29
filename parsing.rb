class Parsing
  def initialize(filepath)
  @filepath = filepath
  end
  def parsing_html_page
    html_content = open(@filepath).read
    document = Nokogiri::XML(html_content)
  end
end
