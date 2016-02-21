sentiment = require "sentiment"

module.exports = (tweet) ->
  tweet.score = sentiment(tweet.text).score
  return tweet
