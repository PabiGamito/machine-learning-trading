require 'twitter' # https://github.com/sferik/twitter
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'sentimental' # https://github.com/7compass/sentimental

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "xVmU8C9RsMg8ARzqim4S7Wh3T"
  config.consumer_secret     = "q0ofXEvmwYQCtCU00hpBDL4F6TmLrJkgUJmVB3YTITbttIUxQK"
  config.access_token        = "1263242148-vwoAkVcera0cO6p0v9uhzcpw64erbpsJtJNdXAV"
  config.access_token_secret = "qeNQ3mQ8ofyeJr0q9R4EBaG6ll0ulhL9VZ21lfTzaiYUH"
end

# Create an instance for usage
analyzer = Sentimental.new
# Load the default sentiment dictionaries
analyzer.load_defaults
# Set a global threshold
analyzer.threshold = 0.1
# If you set the threshold to a non-zero amount, e.g. 0.25:
  # Positive scores are > 0.25
  # Neutral scores are -0.25 - 0.25
  # Negative scores are < -0.25
# Or you can make new analyzers with individual thresholds:
# analyzer = Sentimental.new(threshold: 0.9)

analyzer.score 'I love ruby' #=> 0.925
analyzer.sentiment 'I love ruby' #=> :positive

# Collect the three most recent marriage proposals to @justinbieber
total_sentiment = 0
total_tweets = 10
# mixed: Include both popular and real time results in the response.
# recent: return only the most recent results in the response
# popular: return only the most popular results in the response.
client.search("bitcoin", until: "2016-10-15", lang: "en", result_type: "popular").take(total_tweets).collect do |tweet|
  puts "TWEET:#{tweet.text}"
  setiment = analyzer.score tweet.text
  puts "SENTIMENT: #{setiment}"
  total_sentiment += setiment
end
puts "Average Sentiment: #{total_sentiment/total_tweets}"

# Stream mentions of coffee or tea
# client = Twitter::Streaming::Client.new do |config|
#   config.consumer_key        = "xVmU8C9RsMg8ARzqim4S7Wh3T"
#   config.consumer_secret     = "q0ofXEvmwYQCtCU00hpBDL4F6TmLrJkgUJmVB3YTITbttIUxQK"
#   config.access_token        = "1263242148-vwoAkVcera0cO6p0v9uhzcpw64erbpsJtJNdXAV"
#   config.access_token_secret = "qeNQ3mQ8ofyeJr0q9R4EBaG6ll0ulhL9VZ21lfTzaiYUH"
# end
# topics = ["coffee", "tea"]
# client.filter(track: topics.join(",")) do |object|
#   puts object.text if object.is_a?(Twitter::Tweet)
# end
