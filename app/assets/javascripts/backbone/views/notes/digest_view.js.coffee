SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.DigestView extends Backbone.View
  template: JST["backbone/templates/notes/digest"]

  events:
    "click": 'showNote'
    "click #save-note-btn": "save"

  tagName: 'div'

  attributes:
    class: 'note-view'

  constructor: (options) ->
    super(options)
    @pin = options.pin
    #@model.bind('change', 'noteChanged', this)
    @listenTo(@model, 'sync', @noteSync)
    @listenTo(@model, 'destroy', @noteDestroyed)

    console.log(@model.toJSON())
    console.log(@collection)
  save: ->
    console.log(this)
    @model.unset("errors")
    console.log("going to send")
    console.log(@model.toJSON())
    self = this
    #    @collection.create(@model.toJSON(),
    #      wait: true
    #      success: (note) =>
    #        console.log("note created")
    #      error: (pin, jqXHR) =>
    #        @model.set(errors: $.parseJSON(jqXHR.responseText))
    #    )

    @model.save(@model.toJSON(),
      wait: true
      success: (note) =>
        console.log("note edited")

      error: (note, jqXHR) =>
        self.model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  noteChanged: ->


  noteSync: ->
    console.log("sync")
    console.log(@model.toJSON())
    @render()

  noteDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    self = this
    $(@el).children(".note-title").editable(
      mode:'inline'
      display: false
    #showbuttons: false
      inputclass: 'note-title-input'
      success: (resp, newValue) ->
        console.log(newValue)
        self.model.set('title', newValue)
        console.log(self.model)
        self.save()
    )

    $(@el).children(".note-content").editable(
      mode:'inline'
      type:'textarea'
      display: false
    #showbuttons: false
      inputclass: 'note-content-input'
      success: (resp, newValue) ->
        console.log(newValue)
        self.model.set('content', newValue)
        console.log(self.model)
        self.save()
    )

    return this

  showNote: ->

