_                  = require "lodash"
express            = require "express"
morgan             = require "morgan"
cors               = require "cors"
getTweets          = require "./get_tweets"
calculateSentiment = require "./calculate_sentiment"

app = express()

#  Some server setup
app.use cors()
app.use morgan('combined')
app.use express.static("client")

#  Define your routes.  Later, you can move these into another file.
app.get "/sentiment", (req, res) ->
  person = req.query.person
  # get tweets from last 7 days
  getTweets person, (err, tweets) ->
    if err?
      return res.status(500)
    # calculate sentiment for each tweet
    tweets = tweets.map calculateSentiment

    # average scores per day and return as json
    byDay = {}
    for tweet in tweets
      key = tweet.timestamp.startOf('day').toISOString()
      byDay[key] ?= []
      byDay[key].push tweet

    avgScoresByDay = _.mapValues byDay, (tweets) -> _.mean(_.map(tweets, "score"))
    res.json(avgScoresByDay).send()

# Start the server

port = 8000
app.listen port, ->
  console.log "App listening on port"
