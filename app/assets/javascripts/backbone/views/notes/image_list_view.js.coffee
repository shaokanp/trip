SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.ImageListView extends Backbone.View
  template: JST["backbone/templates/notes/image_list"]

  attributes:
    id:'note-image-list-container'

  events:
    "click #add-new-image-btn": "newImage"

  constructor: (options) ->
    super(options)
    @trip = options.trip
    @pin = options.pin

    @switchToModel(@pin)

  switchToModel: (pin) ->
    if !(pin?)
      return

    @pin = pin
    collection = @pin.notes
    @stopListening(@collection) if @collection?
    @collection = collection

    @loadNotes()

    @listenTo(@collection, 'add', @onNoteAdded)
    @listenTo(@collection, 'remove', @onNoteRemoved)

  loadNotes: ->
    self = @
    @collection.fetch(
      data:
        pin_id: @pin.id
      processData: true
      success: (collection,response,options) ->
        self.render()
      error: (collection,response,options) ->
    )

  newImage: ->
#    $(@el).children('#note-list').prepend(new SampleApp.Views.Notes.NewView(
#      pin: @pin
#      collection: @collection
#    ).render().el)
    model = new SampleApp.Models.Note()
    @collection.add(model)

  removeNote: ->

  onNoteAdded: (note) ->
    @appendNote(note)
  #$($(@el).children(":last-child")).children(":first-child").remove()

  onNoteRemoved: (note) ->
    note.destroy()

  render: ->
    @$el.html(@template())
    self = this;
    console.log('render')
    _.each(@collection.models, (note) ->
      self.appendNote(note)
    )

    return this

  appendNote: (note) ->
    view = new SampleApp.Views.Notes.DigestView(
      pin: @pin
      collection: @collection
      model: note
    )
    @$el.children('#note-list').append(view.render().el)
    if note.isNew()
      console.log('trigger click')
      view.$el.trigger('click')

  prependNote: (note) ->
    @$el.children('#note-list').prepend(new SampleApp.Views.Notes.DigestView(
      pin: @pin
      collection: @collection
      model: note
    ).render().el)