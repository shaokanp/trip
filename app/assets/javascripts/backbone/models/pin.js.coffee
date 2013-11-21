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
    start_time: ''
    end_time: ''
    latitude: '120'
    longitude: '120'
    position: 0

#  relations: [
#    type: Backbone.HasMany
#    key: 'notes'
#    relatedModel: 'SampleApp.Models.Note'
#    collectionType: 'SampleApp.Collections.NotesCollection'
#    reverseRelation:
#      key: 'pin'
#      includeInJSON: 'pin_id'
#  ]

  initialize: ->
    @pins = new SampleApp.Collections.PinsCollection();

class SampleApp.Collections.PinsCollection extends Backbone.Collection
  model: SampleApp.Models.Pin
  url: '/pins'
