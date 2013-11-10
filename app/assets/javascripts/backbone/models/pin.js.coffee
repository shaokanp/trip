class SampleApp.Models.Pin extends Backbone.Model
  paramRoot: 'pin'

  @pinType:
    attraction: 'attraction'
    meeting: 'meeting'
    accommodation: 'accommodation'
    dining: 'dining'
    transport: 'transport'

  defaults:
    trip_id: ''
    pin_type: 'attraction'
    title: ''
    address: ''
    latitude: '120'
    longitude: '120'

class SampleApp.Collections.PinsCollection extends Backbone.Collection
  model: SampleApp.Models.Pin
  url: '/pins'
