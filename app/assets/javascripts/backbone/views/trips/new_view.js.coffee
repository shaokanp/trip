SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.NewView extends Backbone.View
  template: JST["backbone/templates/trips/new"]

  events:
    "click #submit-new-trip-btn": "save"

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
    console.log(@model)
    @collection.create(@model.toJSON(),
      success: (trip) =>
        @model = trip
        window.location = @model.urlRoot + '/' + @model.id;

      error: (trip, jqXHR) =>
        @model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  render: ->
    $(@el).html(@template(@model.toJSON()))

    this.$("form").backboneLink(@model)

    return this
