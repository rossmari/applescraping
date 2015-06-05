class SupportChecker

  attr_reader :imei, :status, :date

  def initialize(imei)
    @imei = imei
  end

  def process
    support_page_content = ImeiPageVisitor.new(imei).content
    parser = CoverageParser.new(support_page_content)
    @status = parser.status
    if @status
      @date = parser.date
    end
  end

end