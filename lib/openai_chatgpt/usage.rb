# frozen_string_literal: true

module OpenaiChatgpt
  # Address object
  class Usage
    attr_reader :prompt_tokens, :completion_tokens, :total_tokens

    def initialize(obj)
      @prompt_tokens = obj.prompt_tokens
      @completion_tokens = obj.completion_tokens
      @total_tokens = obj.total_tokens
    end
  end
end
