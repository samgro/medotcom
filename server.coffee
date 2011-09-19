express = require 'express'
routes = require './routes'

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

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env