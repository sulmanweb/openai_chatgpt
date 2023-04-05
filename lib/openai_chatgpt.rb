# frozen_string_literal: true

require_relative "openai_chatgpt/version"
require "faraday"

# @note: This is a wrapper for the OpenAI Chat GPT API.
module OpenaiChatgpt
  autoload :Error, "openai_chatgpt/error"
  autoload :Client, "openai_chatgpt/client"
  autoload :Object, "openai_chatgpt/object"
  autoload :Response, "openai_chatgpt/response"
  autoload :Usage, "openai_chatgpt/usage"
  autoload :Choice, "openai_chatgpt/choice"
end
