SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin"]

  events:
    "click": "hightlight"
    "dblclick": "edit"
    "click .destroy" : "destroy"

  tagName: "li"

  constructor: (options) ->
    super(options)

    @model.bind("change:errors", () =>
      this.render()
    )

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

  hightlight: ->


  edit: ->
    window.location.hash = "#{@model.id}"
