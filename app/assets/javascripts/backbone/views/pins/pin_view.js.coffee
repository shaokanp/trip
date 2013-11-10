SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin_cell/pin"]

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

    $(@el).attr('pin-type', SampleApp.Models.Pin.pinType.MEETING);

  destroy: () ->
    @model.destroy(
      success: =>
        console.log('delete')
        this.remove()
    )

    return false

  render: ->
    json = @model.toJSON()
    $(@el).html(@template(json))
    return this

  hightlight: ->


  edit: ->
    window.location.hash = "editpin/#{@model.id}"

class SampleApp.Views.Pins.PinListView extends Backbone.View

  initialize: (options) ->
    @collection.bind('add', @addPin, this)
    @collection.bind('reset', @render, this)

  render: ->
    $(@el).html('')
    self = this
    _.each(@collection.models, (pin) ->
       self.addPin(pin)
    )
    return this

  addPin: (pin) ->
    $(@el).append(new SampleApp.Views.Pins.PinView(model: pin).render().el)