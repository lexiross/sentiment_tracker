Twitter = require "twitter"
moment  = require "moment"
_       = require "lodash"

config  = require "../config.json"
handles = require "./twitter_handles"

client = new Twitter {
  consumer_key: config.twitter.consumer_key
  consumer_secret: config.twitter.consumer_secret
  access_token_key: config.twitter.access_token_key
  access_token_secret: config.twitter.access_token_secret
}

params =
  trim_user: true
  exclude_replies: true

module.exports = (person, cb) ->
  handle = handles[person]
  unless handle then return cb null, []

  params.screen_name = handle
  oneWeekAgo = moment().subtract(1, 'week')
  return getTweetsFromDate oneWeekAgo, moment(), null, [], cb

getTweetsFromDate = (targetDate, currentDate, maxId, tweetsSoFar, cb) ->
  if currentDate <= targetDate then return cb null, tweetsSoFar

  if maxId?
    params.max_id = maxId
  client.get 'statuses/user_timeline', params, (err, tweets) ->
    if err?
      return cb err

    if not tweets? or tweets.length is 0
      return cb null, tweetsSoFar

    oldestTweet = _.last tweets
    maxId = oldestTweet.id
    currentDate = moment(new Date(oldestTweet.created_at))
    tweets = _(tweets)
      .filter (tweet) -> moment(new Date(tweet.created_at)) >= targetDate
      .map (tweet) -> {timestamp: moment(new Date(tweet.created_at)), text: tweet.text}
      .value()

    getTweetsFromDate targetDate, currentDate, maxId, tweetsSoFar.concat(tweets), cb
