SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.InfoView extends Backbone.View
  template:
    new: JST["backbone/templates/pins/info_form/new"]
    display: JST["backbone/templates/pins/info_form/show"]

  events:
    "click #submit-new-pin-btn": "save"

  tagName: 'div'

  attributes:
    id: 'pin-info-view'

  mode: 'display' #display mode and new mode

  constructor: (options) ->
    super(options)
    @trip = options.trip;
    @model.bind("destroy", "delete", this)
    @mode = options.mode

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @model.set('trip_id', @trip.id)
    #@model.set('day', window.day)
    console.log(@model)
    console.log(@model.changedAttributes())
    @model.save({},
      patch: true
      wait: true
      success: (pin) =>
        # the sync event will be fired
        #window.location.hash = ''
      error: (pin, jqXHR) =>
        @model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  render: ->
    $(@el).html(@template[@mode](@model.toJSON()))
    if @mode == 'new'
      this.$("#pin-info-form").backboneLink(@model)

    return this

  delete: ->
    @remove()
