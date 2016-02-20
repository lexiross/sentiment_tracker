var express = require("express");
var morgan  = require("morgan");
var cors    = require("cors");
  
var app = express();

/*
  Some server setup
*/
app.use(cors());
app.use(morgan('combined'));
app.use(express.static("client"));

/*
  Define your routes.  Later, you can move these into another file.
*/
app.get("/sentiment", function(req, res) {

});


/*
  Start the server
*/

var port = 8000;
app.listen(port, function() {
  console.log("App listening on port");
});