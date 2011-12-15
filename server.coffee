console.log 'hello heroku'
express = require 'express'
routes = require './routes'
mongoose = require 'mongoose'

# Initialize DB connection
if app.settings.env is 'development'
  mongoose.connect 'mongodb://localhost/medotcom'
  console.log 'Connecting to development DB'
else
  console.log 'Connecting to production DB'
  console.log "  at #{process.env.MONGOHQ_URL}"
  mongoose.connect process.env.MONGOHQ_URL

app = module.exports = express.createServer()

app.configure ->
  app.set "views", "#{__dirname}/views"
  app.set 'view engine', 'html'
  app.register '.html', require('jqtpl').express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static __dirname + '/public'

app.configure 'development', ->
  app.use express.errorHandler dumbExceptions: true, showStack: true

app.configure 'production', ->
  app.use express.errorHandler

routes.set(app)

port = process.env.PORT || 3000
app.listen port, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env