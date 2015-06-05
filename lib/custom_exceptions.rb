module CustomExceptions

  class InvalidDestinationUrl < StandardError

    MESSAGE = 'Invalid destination url %{url}'

    attr_reader :url

    def initialize(url)
      super(MESSAGE % { url: url })
    end

  end

  class StatusParsingError < StandardError

    MESSAGE = 'Failed to parse technical support status of devise.'

    def initialize
      super(MESSAGE)
    end

  end

  class DateParsingError < StandardError

    MESSAGE = 'Failed to parse technical support expiration date.'

    def initialize
      super(MESSAGE)
    end

  end

end