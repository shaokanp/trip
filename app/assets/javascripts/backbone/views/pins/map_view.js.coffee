SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.MapView extends Backbone.View
  #template: JST["backbone/templates/pins/pin"]

  events:

  constructor: (options) ->
    super(options)
    @pins = options.pins
    @pins.bind("add", @addPin)
    @pins.bind("remove", @removePin)

  render: ->
    #$(@el).html(@template(@model.toJSON()))

    _.each(@pins.models, (pin) ->
      console.log('ya');
    )

    return this

  addPin: (pin) ->

  removePin: (pin) ->
