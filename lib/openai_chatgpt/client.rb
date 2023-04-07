# frozen_string_literal: true

module OpenaiChatgpt
  # Client having API methods and api_key
  class Client
    # Base url for OpenAI ChatGPT API
    BASE_URL = "https://api.openai.com/v1/chat/completions"
    attr_reader :api_key, :adapter

    # #### Params:
    # api_key: String - Required - API key for OpenAI ChatGPT API (https://platform.openai.com/account/api-keys)
    # adapter: Symbol - Optional - Default: :net_http - Adapter for Faraday connection
    # stubs: Faraday::Adapter::Test::Stubs - Optional - Default: nil - Stubs for Faraday connection
    # request_timeout: Integer - Optional - Default: 1200 - Timeout for Faraday connection
    # #### Example:
    # client = OpenaiChatgpt::Client.new api_key: "test"
    # #### Description:
    # Client for OpenAI ChatGPT API
    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil, request_timeout: 1200)
      @api_key = api_key
      @adapter = adapter
      @request_timeout = request_timeout

      # Test stubs for requests
      @stubs = stubs
    end

    # #### Params:
    # messages: Array[String] - Required - Messages to generate response for
    #   [{role: "user", text: "Hello"}, {role: "bot", text: "Hi"}]
    # model: String - Optional - Default: "gpt-4" - Model to use for generating response
    #   ["gpt-4", "gpt-4-0314", "gpt-4-32k", "gpt-4-32k-0314", "gpt-3.5-turbo", "gpt-3.5-turbo-0301"]
    # temperature: Float - Optional - Default: 1.0 - Temperature for response generation between 0.0 and 2.0
    # top_p: Float - Optional - Default: 1.0 - Top p for response generation between 0.0 and 1.0
    # n: Integer - Optional - Default: 1 - Number of responses to generate
    # stream: Boolean - Optional - Default: false - Stream response
    # stop: Array[String] - Optional - Default: nil - Stop sequence for response generation
    # max_tokens: Integer - Optional - Default: 4096 - Maximum number of tokens to generate
    # presence_penalty: Float - Optional - Default: 0.0 - Presence penalty for response generation between -2.0 and 2.0
    # frequency_penalty: Float - Optional - Default: 0.0 - Frequency penalty for response generation between
    #   -2.0 and 2.0
    # logit_bias: Hash - Optional - Default: nil - Logit bias for response generation
    # user: String - Optional - Default: nil - User for response generation
    # #### Example:
    # OpenaiChatgpt::Client.new(api_key: "fake")
    #   .completions(messages: [{role: "user", content: "Hello"}, {role: "assistant", content: "Hi"}])

    # #### Description:
    # completions method for OpenAI ChatGPT API
    # #### Response:
    # Response object with choices
    # #### Error:
    # OpenaiChatgpt::Error
    def completions( # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
      messages:,
      model: "gpt-4",
      temperature: 1.0,
      top_p: 1.0,
      n: 1, # rubocop:disable Naming/MethodParameterName
      stream: false,
      stop: nil,
      max_tokens: 2000,
      presence_penalty: 0,
      frequency_penalty: 0,
      logit_bias: {},
      user: ""
    )
      Response.new post("", {
        model: model,
        messages: messages,
        temperature: temperature,
        top_p: top_p,
        n: n,
        stream: stream,
        stop: stop,
        max_tokens: max_tokens,
        presence_penalty: presence_penalty,
        frequency_penalty: frequency_penalty,
        logit_bias: logit_bias,
        user: user
      }.to_json)
    end

    private

    # makes a get request to the given path with params
    def post(path, params = {})
      handle_response connection.post(path, params)
    end

    # handles the response from the api and raises error if any
    # returns the response if no error
    # Error codes: https://platform.openai.com/docs/guides/error-codes/api-errors
    def handle_response(response)
      return response if response.status == 200

      raise Error, "#{response.status}: #{response.body["error"]["message"]}"
    end

    # creates a faraday connection with base url and api_key
    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.headers["Authorization"] = "Bearer #{@api_key}"
        conn.headers["Content-Type"] = "application/json"
        conn.options.timeout = @request_timeout
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
      end
    end
  end
end
