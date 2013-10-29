SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.TripDigestView extends Backbone.View
  template: JST["backbone/templates/trips/trip_digest"]

  events:
    "click": "show"
    "click .destroy" : "destroy"

  tagName: "li"

  className:'trip-digest span2'

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  show: ->
    app.navigate('trips/' + @model.id, true);
