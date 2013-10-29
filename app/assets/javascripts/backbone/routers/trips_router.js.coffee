class SampleApp.Routers.TripsRouter extends Backbone.Router
  initialize: (options) ->
    @trips = new SampleApp.Collections.TripsCollection()
    @trips.reset options.trips
    @trip = new SampleApp.Models.Trip()
    @trip.set options.trip

  routes:
    "new"      : "newTrip"
    ":id/edit" : "edit"
    ":id"      : "show"

  newTrip: ->
    @view = new SampleApp.Views.Trips.NewView(collection: @trips)
    $("body").append(@view.render().el)

  show: (id) ->
    @view = new SampleApp.Views.Trips.ShowView(model: @trip)
    $("#trips").html(@view.render().el)

  edit: (id) ->
    @view = new SampleApp.Views.Trips.EditView(model: @trip)
    $("#trips").html(@view.render().el)
