SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.ShowView extends Backbone.View
  template: JST["backbone/templates/notes/show"]

  events:
    "click #note-view-save-btn": "saveNote"
    "click #note-view-image-btn": "addImage"
    "click #note-view-delete-btn": "deleteNote"
    "click #note-view-close-btn": "closeNote"

  tagName: 'div'

  attributes:
    id: 'note-view'

  constructor: (options) ->
    super(options)
    @pin = options.pin

    if options.model? # show a loaded note

    else # new a note
      @model = new SampleApp.Models.Note(
        pin_id: @pin.id
      )
    #@loadNote(options.note_id)

    @switchToModel(@model)


  switchToModel: (model) ->
    if !(model?)
      return

    @stopListening(@model) if @model?
    @model = model

    #@listenTo(@model, 'sync', @noteSync)
    @listenTo(@model, 'destroy', @noteDestroyed)

  saveNote: ->
    @model.unset("errors")
    @model.set('title', @noteTitle_el.data().editable.input.$input.val())
    @model.set('content', @noteContent_el.data().editable.input.$input.val())
    console.log(@model.toJSON())

    self = this
    @model.save(@model.toJSON(),
      wait: true
      success: (note) =>
        console.log("note edited")

      error: (note, jqXHR) =>
          self.model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  loadNote: (note_id) ->
    self = @
    @model.fetch(
      wait: true
      success: (note) =>
        console.log("note edited")
        @render()
      error: (note, jqXHR) =>
        self.model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  noteSync: ->
    console.log("sync")
    console.log(@model.toJSON())
    @render()

  noteDestroyed: ->
    @remove()

  deleteNote: ->
    @model.destroy()

  closeNote: ->
    keyword = '/notes/'
    index = window.location.hash.indexOf(keyword)
    window.router.navigate(window.location.hash.substring(0,index))

    @remove()

  addImage: ->
    $("body").append(new SampleApp.Views.Notes.NewImageView(model: @model).render().el)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    self = this

    @noteTitle_el = $(@el).children(".note-title")
    @noteTitle_el.editable(
      mode:'inline'
      #showbuttons: false
      inputclass: 'note-title-input'
      success: (resp, newValue) ->
        console.log(newValue)
        self.model.set('title', newValue)
        console.log(self.model)
        self.save()
    ).editable('show')

    @noteContent_el = $(@el).children(".note-content")
    @noteContent_el.editable(
      mode:'inline'
      type:'textarea'
      showbuttons: false
      inputclass: 'note-content-input'
      success: (resp, newValue) ->
        console.log(newValue)
        self.model.set('content', newValue)
        console.log(self.model)
        self.save()
    ).editable('show')

    return this
