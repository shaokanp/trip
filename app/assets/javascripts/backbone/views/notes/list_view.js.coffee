SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.NoteListView extends Backbone.View
  #template: JST["backbone/templates/notes/list"]

  events:
    "click #save-note-btn": "save"
    "click #add-new-note-btn": "newNote"

  tagName: 'div'

  attributes:
    id: 'pin-note-list'

  constructor: (options) ->
    super(options)
    @trip = options.trip
    @pin = options.pin
    @collection.bind('add', 'addNote', this)
    @collection.bind('remove', 'removeNote', this)

  save: (e) ->

  addNote: (note) ->

  removeNote: (note) ->


  render: ->
    #$(@el).html(@template())
    _.each(@collection, (note) ->
      $(@el).append(new SampleApp.Views.Notes.ShowView(
        pin: @pin
        model: note
      ).render().el)
    )

    return this
