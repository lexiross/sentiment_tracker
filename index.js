var express = require("express");
var morgan  = require("morgan");
var cors    = require("cors");
  
var app = express();

// /*
//   Some server setup
// */
app.use(cors());
app.use(morgan('combined'));

/*
  Define your routes.  Later, you can move these into another file.
*/

app.get("/sentiment", function(req, res) {
  
  // do stuff, maybe with req.query
  // then send by res.status(number).json(obj).send()

});


/*
  Start the server
*/

var port = // pick me;
app.listen(port, function() {
  console.log("App listening on port");
});