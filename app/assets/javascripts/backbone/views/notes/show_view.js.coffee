SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.ShowView extends Backbone.View
  template: JST["backbone/templates/notes/show"]

  events:
    "click #save-note-btn": "save"
    "click #add-new-note-btn": "newNote"

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
    @model.set('trip_id', @trip.id)

    @collection.create(@model.toJSON(),
      wait: true
      success: (pin) =>
        window.location.hash = ''
      error: (pin, jqXHR) =>
        @model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  noteChanged: ->


  noteSync: ->


  noteDestroyed: ->
    @remove()

  render: ->
    #$(@el).html(@template())

    return this
