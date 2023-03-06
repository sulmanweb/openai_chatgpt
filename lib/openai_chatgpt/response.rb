# frozen_string_literal: true

module OpenaiChatgpt
  # Response object formatted from OpenaiChatgpt response
  class Response
    attr_reader :raw_response, :results, :usage

    def initialize(response)
      @raw_response = Object.new response.body
      @results = @raw_response.choices.map { |choice| Choice.new choice }
      @usage = Usage.new @raw_response.usage
    end
  end
end
