SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.ShowView extends Backbone.View
  template: JST["backbone/templates/pins/pin"]

  initialize: (options) ->
    @listenTo(@model, 'add', @addPin)
    @listenTo(@model, 'reset', @render)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  addPin: (pin) ->
    $(@el).append(@template(pin.toJSON()))



