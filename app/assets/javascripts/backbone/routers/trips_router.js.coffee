class SampleApp.Routers.TripsRouter extends Backbone.Router
  initialize: (options) ->
    @trip = new SampleApp.Models.Trip()
    @trip.set options.trip
    @trip.pins.reset(options.trip.pins)

    @before()

  routes:
    ""      : "show"
    "edit" : "edit"
    "newpin/:type"   : "newPin"
    "editpin/:id"  : "editPin"

  before: ->
    view = new SampleApp.Views.Pins.PinListView(
      collection: @trip.pins
      el: $('#pin-panel')
    )
    view.render()

    view = new SampleApp.Views.Pins.MapView({
      pins: @trip.pins
      el: $('#map')
    })
    view.render()

  show: ->
    @view.remove() if @view?

  edit: ->
    @view = new SampleApp.Views.Trips.EditView(collection: @trips)
    $("body").append(@view.render().el)

  newPin: (type) ->
    @view = new SampleApp.Views.Pins.NewView(
      trip: @trip,
      collection: @trip.pins
    )
    $("#pin-info-container").html(@view.render().el)

  editPin: (pin_id) ->
    @view = new SampleApp.Views.Pins.EditView(model: @trip.pins.get(pin_id))
    $("#pin-info-container").html(@view.render().el)


