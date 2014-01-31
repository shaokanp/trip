class SampleApp.Models.Trip extends Backbone.Model
  paramRoot: 'trip'
  urlRoot: '/trips'

  defaults:
    title: ''
    cover_image_url: ''
    description: ''
    start_time: ''
    days: ''
    is_public: false

  initialize: ->
    @pins = new SampleApp.Collections.PinsCollection();

class SampleApp.Collections.TripsCollection extends Backbone.Collection
  model: SampleApp.Models.Trip
  url: '/trips'
