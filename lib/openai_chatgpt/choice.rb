# frozen_string_literal: true

module OpenaiChatgpt
  # @note: This class is the choice response object.
  class Choice
    attr_reader :content, :index, :role

    def initialize(obj)
      @content = obj.message.content
      @index = obj.index
      @role = obj.message.role
    end
  end
end
