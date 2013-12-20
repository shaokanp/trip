SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.NewView extends Backbone.View
  template: JST["backbone/templates/pins/info_form/new"]

  events:
    "click #submit-new-pin-btn": "save"

  tagName: 'div'

  attributes:
    id: 'pin-info-form-container'

  constructor: (options) ->
    super(options)
    @trip = options.trip;
    @model = new SampleApp.Models.Pin()
    @model.set('pin_type', options.type)

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

  render: ->
    $(@el).html(@template(@model.toJSON()))

    this.$("#pin-info-form").backboneLink(@model)

    return this
