# frozen_string_literal: true

require "ostruct"

module OpenaiChatgpt
  # OpenStruct object for OpenaiChatgpt
  class Object < OpenStruct # rubocop:disable Style/OpenStructUse
    def initialize(attributes)
      super to_ostruct(attributes)
    end

    def to_ostruct(obj)
      if obj.is_a?(Hash) # rubocop:disable Style/CaseLikeIf
        OpenStruct.new(obj.map { |key, val| [key, to_ostruct(val)] }.to_h) # rubocop:disable Style/HashTransformValues, Style/OpenStructUse, Style/MapToHash
      elsif obj.is_a?(Array)
        obj.map { |o| to_ostruct(o) }
      else # Assumed to be a primitive value
        obj
      end
    end
  end
end
