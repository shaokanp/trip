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

  noteSync: ->
    @render()

  noteDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    return this

  showNote: ->
    keyword = '/notes/'
    index = window.location.hash.indexOf(keyword)

    if index == -1
      window.location.hash = window.location.hash + "/notes/#{@model.id}"

    else
      window.location.hash = window.location.hash.substring(0,index+keyword.length) + "#{@model.id}"
