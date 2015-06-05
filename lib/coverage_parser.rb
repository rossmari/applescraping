require 'nokogiri'
require 'custom_exceptions'

class CoverageParser

  STATUS_PHRASE = 'Telephone Technical Support:'
  DATE_PHRASE = 'Estimated Expiration Date:'

  attr_reader :document

  def initialize(page_content)
    @document = Nokogiri::HTML(page_content)
  end

  def status
    find_by_phrase('h3', STATUS_PHRASE) == 'Active'
  rescue
    raise CustomExceptions::StatusParsingError.new
  end

  def date
    Date.parse(parse_date)
  rescue
    raise CustomExceptions::DateParsingError.new
  end

  private

  def parse_date
    html = document.xpath("//p[@id='phone-text']").inner_html
    html.match(/#{DATE_PHRASE}(.+)<br>/)[1]
  end

  def find_by_phrase(tag, phrase)
    all_elements = document.xpath("//#{tag}[contains(text(), \"#{phrase}\")]")
    # only visible
    element = all_elements.reject { |element| element.attributes['style'].value == 'display: none' }.first
    element.text.match(/#{phrase}\s*(\S+)/)[1]
  end

end