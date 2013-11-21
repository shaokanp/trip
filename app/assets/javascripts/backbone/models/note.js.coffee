class SampleApp.Models.Note extends Backbone.Model
  paramRoot: 'note'

  @pinType:
    attraction: 'attraction'
    meeting: 'meeting'
    accommodation: 'accommodation'
    dining: 'dining'
    transport: 'transport'

  defaults:
    pin_id: ''
    title: ''
    content: '' #html

class SampleApp.Collections.NotesCollection extends Backbone.Collection
  model: SampleApp.Models.Note
  url: '/notes'
