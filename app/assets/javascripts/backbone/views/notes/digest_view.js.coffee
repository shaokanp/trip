SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.DigestView extends Backbone.View
  template: JST["backbone/templates/notes/digest"]

  events:
    "click": 'showNote'

  tagName: 'div'

  attributes:
    class: 'note-digest-view'

  constructor: (options) ->
    super(options)
    @pin = options.pin
    #@model.bind('change', 'noteChanged', this)
    @listenTo(@model, 'sync', @noteSync)
    @listenTo(@model, 'destroy', @noteDestroyed)

    console.log(@model.toJSON())
    console.log(@collection)

  noteSync: ->
    console.log("sync")
    console.log(@model.toJSON())
    @render()

  noteDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    return this

  showNote: ->
    window.location.hash = window.location.hash + "/notes/#{@model.id}"


