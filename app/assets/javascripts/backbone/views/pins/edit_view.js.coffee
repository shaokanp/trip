SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.EditView extends Backbone.View
  template: JST["backbone/templates/pins/info_form/info_form"]

  events:
    "click #submit-new-pin-btn": "save"

  tagName: 'div'

  attributes:
    id: 'pin-info-form-container'

  constructor: (options) ->
    super(options)
    @trip = options.trip;
    @model.bind("destroy", "delete", this)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    console.log(@model.changedAttributes())
    @model.save({},
      patch: true
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

  delete: ->
    @remove()
