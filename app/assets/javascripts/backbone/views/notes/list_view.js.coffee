SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.NoteListView extends Backbone.View
  #template: JST["backbone/templates/notes/list"]

  events:
    "click #add-new-note-btn": "newNote"

  tagName: 'div'

  attributes:
    id: 'pin-note-list'

  constructor: (options) ->
    super(options)
    @trip = options.trip
    @pin = options.pin
    @collection.bind('add', 'onNoteAdded', this)
    @collection.bind('remove', 'onNoteRemoved', this)


  newNote: ->
    @prependNote(new SampleApp.Models.Note(
      pin_id: @pin.id
    ))

  removeNote: ->

  onNoteAdded: (note) ->

  onNoteRemoved: (note) ->

  render: ->
    #$(@el).html(@template())
    _.each(@collection, (note) ->
      @appendNote(note)
    )

    return this

  appendNote: (note) ->
    $(@el).append(new SampleApp.Views.Notes.ShowView(
      pin: @pin
      model: note
    ).render().el)

  prependNote: (note) ->
    $(@el).prepend(new SampleApp.Views.Notes.ShowView(
      pin: @pin
      model: note
    ).render().el)