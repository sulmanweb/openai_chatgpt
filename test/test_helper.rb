# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "openai_chatgpt"
require "minitest/autorun"
require "faraday"
require "json"

# :nodoc:
class Minitest::Test # rubocop:disable Style/ClassAndModuleChildren
  def stub_response(fixture:, status: 200, headers: { "Content-Type" => "application/json" })
    [status, headers, File.read("test/fixtures/#{fixture}.json")]
  end

  def stub_request(path, response:, method: :get, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      arguments = [method, "/#{path}"]
      arguments << body.to_json if %i[post put patch].include?(method)
      stub.send(*arguments) { |_env| response }
    end
  end
end
