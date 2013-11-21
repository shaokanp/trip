SampleApp.Views.Dashboard ||= {}

class SampleApp.Views.Dashboard.IndexView extends Backbone.View
  template: JST["backbone/templates/dashboard/index"]

  initialize: (options) ->
    @collection = options.trips
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (trip) =>
    view = new SampleApp.Views.Trips.TripDigestView({model : trip})
    @$("#trips-container").append(view.render().el)

  render: =>
    $(@el).html(@template(trips: @collection.toJSON()))
    @addAll()

    return this
