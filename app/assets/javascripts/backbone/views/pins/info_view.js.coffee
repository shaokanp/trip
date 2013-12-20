SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.InfoView extends Backbone.View
  template: JST["backbone/templates/pins/info_form/show"]

  events:
    "click #save-pin-btn": "save"

  tagName: 'div'

  attributes:
    id: 'pin-info-container'

  mode: 'display' #display mode and edit mode

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
