class SampleApp.Models.Pin extends Backbone.Model
  paramRoot: 'pin'
  url: ->
    u = "/pins/"
    u = "#{u}#{this.id}" if this.id
    u

  @pinType:
    attraction: 'attraction'
    meeting: 'meeting'
    accommodation: 'accommodation'
    dining: 'dining'
    transport: 'transport'

  marker: null

  defaults:
    trip_id: ''
    pin_type: 'attraction'
    title: ''
    address: ''
    start_time: ''
    end_time: ''
    day_id: 1
    latitude: '120'
    longitude: '120'
    position: 0
    move_origin: -1
    move_dest: -1

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
    @notes = new SampleApp.Collections.NotesCollection()

class SampleApp.Collections.PinsCollection extends Backbone.Collection
  model: SampleApp.Models.Pin
  url: '/pins'
