require 'capybara'
require 'capybara-webkit'
require 'custom_exceptions'

class ImeiPageVisitor

  attr_reader :imei, :session

  IMEI_PAGE_HTTP = 'https://selfsolve.apple.com/agreementWarrantyDynamic.do'
  COVERAGE_PAGE_HTTP = 'https://selfsolve.apple.com/wcResults.do'

  def initialize(imei)
    @imei = imei
    create_capybara_session
    get_coverage_page
  end

  def content
    if session.current_url == COVERAGE_PAGE_HTTP
      session.html
    else
      raise CustomExceptions::InvalidDestinationUrl.new(session.current_url)
    end
  end

  private

  def get_coverage_page
    session.visit(IMEI_PAGE_HTTP)
    session.fill_in('sn', with: imei)
    session.click_button('Continue')
  end

  def create_capybara_session
    Capybara.app_host = 'http://google.com'
    @session = Capybara::Session.new(:webkit)
    @session.driver.allow_url('apple.com')
  end

end