class SampleApp.Models.Trip extends Backbone.Model
  paramRoot: 'trip'

  defaults:
    title: ''
    image: ''

class SampleApp.Collections.TripsCollection extends Backbone.Collection
  model: SampleApp.Models.Trip
  url: '/trips'
