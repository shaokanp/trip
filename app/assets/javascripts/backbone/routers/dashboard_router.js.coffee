class SampleApp.Routers.DashboardRouter extends Backbone.Router
  initialize: (options) ->
    @trips = new SampleApp.Collections.TripsCollection()
    @trips.reset options.trips

  routes:
    "new"      : "newTrip"
    "index"    : "index"
    ".*"        : "index"

  newTrip: ->
    @view = new SampleApp.Views.Trips.NewView(collection: @trips)
    $("body").append(@view.render().el)

  index: ->
    @view.remove() if @view?
    @view = new SampleApp.Views.Dashboard.IndexView(trips: @trips)
    $("#dashboard").html(@view.render().el)
