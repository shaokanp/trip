SampleApp.Views.Dashboard ||= {}

class SampleApp.Views.Dashboard.IndexView extends Backbone.View
  template: JST["backbone/templates/dashboard/index"]

  initialize: () ->
    @options.trips.bind('reset', @addAll)

  addAll: () =>
    @options.trips.each(@addOne)

  addOne: (trip) =>
    view = new SampleApp.Views.Trips.TripDigestView({model : trip})
    @$("#trips-container").append(view.render().el)

  render: =>
    $(@el).html(@template(trips: @options.trips.toJSON()))
    @addAll()

    return this
