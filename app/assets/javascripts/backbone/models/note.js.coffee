class SampleApp.Models.Note extends Backbone.RelationalModel
  paramRoot: 'note'

  @pinType:
    attraction: 'attraction'
    meeting: 'meeting'
    accommodation: 'accommodation'
    dining: 'dining'
    transport: 'transport'

  defaults:
    pin_id: ''
    content: '' #html
    created_time: ''
    updated_time: ''

class SampleApp.Collections.NotesCollection extends Backbone.Collection
  model: SampleApp.Models.Note
  url: '/notes'
