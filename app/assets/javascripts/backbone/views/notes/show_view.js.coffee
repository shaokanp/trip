SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.ShowView extends Backbone.View
  template: JST["backbone/templates/notes/show"]

  events:
    "click #save-note-btn": "save"

  tagName: 'div'

  attributes:
    class: 'note-view'

  constructor: (options) ->
    super(options)
    @pin = options.pin
    #@model.bind('change', 'noteChanged', this)
    @model.bind('save', 'noteSaved', this)
    @model.bind('destroy', 'noteDestroyed', this)

    console.log(@model.toJSON())
    console.log(@collection)
  save: ->

    @model.unset("errors")
    console.log("going to send")
    console.log(@model.toJSON())
#    @collection.create(@model.toJSON(),
#      wait: true
#      success: (note) =>
#        console.log("note created")
#      error: (pin, jqXHR) =>
#        @model.set(errors: $.parseJSON(jqXHR.responseText))
#    )

    @model.save(@model.toJSON(),
      patch: true
      wait: true
      success: (note) =>
        console.log("note created")
        $(@el).html(@template(@model.toJSON()))
        @collection.add(note)
        error: (pin, jqXHR) =>
          @model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  noteChanged: ->


  noteSync: ->


  noteDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    self = this
    $(@el).children("p").editable(
      mode:'inline'
      display: false
      success: (resp, newValue) ->
        console.log(newValue)
        self.model.set('content', newValue)
        console.log(self.model)
        self.save()
    )

    return this
