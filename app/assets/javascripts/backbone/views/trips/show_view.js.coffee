SampleApp.Views.Trips ||= {}

class SampleApp.Views.Trips.ShowView extends Backbone.View
  template: JST["backbone/templates/trips/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
