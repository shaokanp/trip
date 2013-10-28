SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.EditView extends Backbone.View
  template : JST["backbone/templates/trips/edit"]

  events :
    "submit #edit-trip" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (trip) =>
        @model = trip
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
