SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin"]

  events:
    "click": "hightlight"
    "dblclick": "edit"
    "click .destroy" : "destroy"

  tagName: "li"
  className: "pin-cell"

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

class SampleApp.Views.Pins.PinListView extends Backbone.View

  initialize: (options) ->
    @model.bind('add', @addPin)
    @model.bind('reset', @render)

  render: ->
    $(@el).html('')
    self = this
    _.each(@model.models, (pin) ->
       self.addPin(pin)
    )
    return this

  addPin: (pin) ->
    $(@el).append(new SampleApp.Views.Pins.PinView(model: pin).render().el)
    console.log($(@el).children())

