Page = require './models/page'

# Function for logging each request
logRequest = (req) ->
  console.log "#{req.method} #{req.url} #{new Date()}"

# Set routes
set = (app) ->
  # :id
  app.param 'slug', (req, res, next, slug) ->
    Page.findOne slug: req.params.slug, (err, page) ->
      if err?
        next err
      else unless page?
        next(new Error "Failed to load page #{slug}")
      else
        req.page = page
        next()

  # index
  app.get '/', (req, res) ->
    logRequest(req)
    Page.find().desc('date').exec (err, pages) ->
      res.render 'index',
        title: 'Sam Grossberg',
        pages: pages

  # show
  app.get '/:slug', (req, res) ->
    logRequest(req)
    res.render 'page/show',
      title: req.page.title
      article: req.page

  # new
  app.get '/pages/new', (req, res) ->
    logRequest(req)
    res.render 'pages/new', title: 'New Page'

  # create
  app.post '/pages', (req, res) ->
    page = new Page(req.body.page)
    page.date = new Date()
    page.save (err) ->
      res.redirect "/#{page.slug}"
    
exports.set = set