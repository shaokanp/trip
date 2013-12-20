SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.ShowView extends Backbone.View
  template: JST["backbone/templates/pins/info_form/edit"]

  constructor: (options) ->
    super(options)
    @setElement($('#right-container'))

  render: ->
    $(@el).html(@template(@model.toJSON()))

    this.$("#pin-info-form").backboneLink(@model)

    return this

