class SampleApp.Models.Pin extends Backbone.Model
  paramRoot: 'pin'

  defaults:
    trip_id: ''
    title: ''
    address: ''
    latitude: '120'
    longitude: '120'

class SampleApp.Collections.PinsCollection extends Backbone.Collection
  model: SampleApp.Models.Pin
  url: '/pins'
