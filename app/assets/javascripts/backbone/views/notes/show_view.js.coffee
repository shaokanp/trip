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
    @model.bind('change', 'noteChanged', this)
    @model.bind('sync', 'noteSync', this)
    @model.bind('destroy', 'noteDestroyed', this)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @model.set('pin_id', @pin.id)

    @collection.create(@model.toJSON(),
      wait: true
      success: (note) =>

      error: (pin, jqXHR) =>
        @model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  noteChanged: ->


  noteSync: ->


  noteDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))


    return this
