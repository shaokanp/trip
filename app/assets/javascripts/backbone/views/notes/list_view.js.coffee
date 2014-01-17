SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.NoteListView extends Backbone.View
  template: JST["backbone/templates/notes/list"]

  events:
    "click #add-new-note-btn": "newNote"

  tagName: 'div'

  attributes:
    id: 'pin-note-list'

  constructor: (options) ->
    super(options)
    @trip = options.trip
    @pin = options.pin
    @listenTo(@collection, 'add', @onNoteAdded)
    @listenTo(@collection, 'remove', @onNoteRemoved)
    @loadNotes()

  loadNotes: ->
    @collection.fetch(
      data:
        pin_id: @pin.id
      processData: true
      success: (collection,response,options) ->

      error: (collection,response,options) ->
    )

  newNote: ->
    $($(@el).children(":last-child")).append(new SampleApp.Views.Notes.NewView(
      pin: @pin
      collection: @collection
    ).render().el)

  removeNote: ->

  onNoteAdded: (note) ->
    console.log(note)
    @appendNote(note)


  onNoteRemoved: (note) ->

  render: ->
    $(@el).html(@template())
    self = this;

    _.each(@collection.models, (note) ->
      self.appendNote(note)
    )

    return this

  appendNote: (note) ->
    $($(@el).children(":last-child")).append(new SampleApp.Views.Notes.ShowView(
      pin: @pin
      collection: @collection
      model: note
    ).render().el)

  prependNote: (note) ->
    $($(@el).children(":last-child")).prepend(new SampleApp.Views.Notes.ShowView(
      pin: @pin
      collection: @collection
      model: note
    ).render().el)