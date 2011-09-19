# Function for logging each request
logRequest = (req) ->
  console.log "#{req.method} #{req.url} #{new Date()}"

# Set routes
set = (app) ->
  # Index
  app.get '/', (req, res) ->
    logRequest(req)
    res.render 'index'

  # Blog
  app.get '/:id', (req, res) ->
    logRequest(req)
    res.render 'blog/show'

  app.get '/blog/new', (req, res) ->
    logRequest(req)
    res.render 'blog/new'

exports.set = set