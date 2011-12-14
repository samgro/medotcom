mongoose = require 'mongoose'
Schema = mongoose.Schema

Page = new Schema
  title:        { type: String, index: true },
  slug:         { type: String, index: true },
  body:         String,
  excerpt:      String,
  publish_date: { type: Date, index: true }
  
exports = module.exports = mongoose.model('Page', Page);