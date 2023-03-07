# OpenaiChatgpt

OpenAI ChatGPT API is a light-weight Ruby wrapper for the Rubyists. It gives nice struct objects for completions of the chatgpt, even the raw responses are returned in nice open struct objects. It uses Faraday for HTTP requests.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add openai_chatgpt

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install openai_chatgpt

---

## Usage

### API Documentation

The API documentation can be found at [https://platform.openai.com/docs/api-reference/chat/create](https://platform.openai.com/docs/api-reference/chat/create).

### Get an API key
You can get API for the chatgpt by doing the following [here](https://platform.openai.com/account/api-keys).

### Configuration

```ruby
require 'openai_chatgpt'
client = OpenaiChatgpt::Client.new(api_key: ENV['CHATGPT_API_KEY'])
```
Params:
- `api_key`: String - Required - The API key for the openai chatgpt api.

Response:
```ruby
#<OpenaiChatgpt::Client:0x00000001055fc318 @adapter=:net_http, @api_key="YOUR_API_KEY", @stubs=nil>
```

### Get completion text

```ruby
resp = OpenaiChatgpt::Client.new(api_key: "fake").completions(
  messages: [
    {role: "user", content: "Hello, how are you?"},
    {role: "assistant", content: "I am good, how are you?"},
    {role: "user", content: "What is your name?"},
  ]
)
```
Params:
- messages: Array[String] - Required - Messages to generate response for
   `[{role: "user", text: "Hello"}, {role: "bot", text: "Hi"}]`
- model: String - Optional - Default: "gpt-3.5-turbo" - Model to use for generating response
   ["gpt-3.5-turbo", "gpt-3.5-turbo-0301"]
- temperature: Float - Optional - Default: 1.0 - Temperature for response generation between 0.0 and 2.0
- top_p: Float - Optional - Default: 1.0 - Top p for response generation between 0.0 and 1.0
- n: Integer - Optional - Default: 1 - Number of responses to generate
- stream: Boolean - Optional - Default: false - Stream response
- stop: Array[String] - Optional - Default: nil - Stop sequence for response generation
- max_tokens: Integer - Optional - Default: 4096 - Maximum number of tokens to generate
- presence_penalty: Float - Optional - Default: 0.0 - Presence penalty for response generation between -2.0 and 2.0
- frequency_penalty: Float - Optional - Default: 0.0 - Frequency penalty for response generation between
   -2.0 and 2.0
- logit_bias: Hash - Optional - Default: nil - Logit bias for response generation
- user: String - Optional - Default: nil - User for response generation

Response:
```ruby
resp.results
=> [#<OpenaiChatgpt::Choice:0x0000000107abca68 @content="I am an AI language model created by Open", @index=0, @role="assistant">]
```
```ruby
resp.usage
=> #<OpenaiChatgpt::Usage:0x0000000107aba808 @completion_tokens=10, @prompt_tokens=36, @total_tokens=46>
```

> Also `raw_response` is available if you want the raw response from the API. This is useful if you want to do something with the raw response. Also that response is in OpenStruct Object which is a nice wrapper for the raw response and you can use 'dot' notation.

### Error Handling

```ruby
begin
  client.completions(messages: [{role: "user", text: "Hello, how are you?"}]) # this should be content instead of text
rescue OpenaiChatgpt::Error => e
  puts e.message
end
```

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/openai_chatgpt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/openai_chatgpt/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OpenaiChatgpt project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/openai_chatgpt/blob/main/CODE_OF_CONDUCT.md).
