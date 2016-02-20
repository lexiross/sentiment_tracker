express = require "express"
morgan  = require "morgan"
cors    = require "cors"

app = express()

#  Some server setup
app.use cors()
app.use morgan('combined')
app.use express.static("client")

#  Define your routes.  Later, you can move these into another file.
app.get "/sentiment", (req, res) ->


# Start the server

port = 8000
app.listen port, ->
  console.log "App listening on port"
