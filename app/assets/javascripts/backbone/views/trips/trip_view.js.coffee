SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.TripView extends Backbone.View
  template: JST["backbone/templates/trips/trip"]

  events:
    "click": "show"
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  show: ->
    app.navigate('trips/' + @model.id, true);
