SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.NewView extends Backbone.View
  template: JST["backbone/templates/trips/new"]

  events:
    "submit #new-trip-btn": "save"

  tagName: 'div'

  attributes:
    id: 'trip-info-form-container'

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (trip) =>
        @model = trip
        if Backbone.history.fragment is "dashboard"
          app.navigate('trips/' + @model.id, true);
        else
          window.location.hash = "/#{@model.id}"

      error: (trip, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON()))

    this.$("form").backboneLink(@model)

    return this
