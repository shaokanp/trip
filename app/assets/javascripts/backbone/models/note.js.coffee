class SampleApp.Models.Note extends Backbone.Model
  paramRoot: 'note'
  url: '/notes'

  @pinType:
    attraction: 'attraction'
    meeting: 'meeting'
    accommodation: 'accommodation'
    dining: 'dining'
    transport: 'transport'

  defaults:
    pin_id: ''
    #title: 'title'
    content: '' #html
    image: '' #string

class SampleApp.Collections.NotesCollection extends Backbone.Collection
  model: SampleApp.Models.Note
  url: '/notes'
