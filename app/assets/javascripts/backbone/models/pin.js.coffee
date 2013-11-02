class SampleApp.Models.Pin extends Backbone.Model
  paramRoot: 'pin'

  defaults:
    title: ''
    address: ''
    latitude: ''
    longitude: ''

class SampleApp.Collections.PinsCollection extends Backbone.Collection
  model: SampleApp.Models.Pin
  url: '/pins'
