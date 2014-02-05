class SampleApp.Routers.TripsRouter extends Backbone.Router
  initialize: (options) ->
    @trip = new SampleApp.Models.Trip()
    @trip.set options.trip

    @before()

  routes:
    ""      : "show"
    "edit" : "edit"
    "newpin/:type"   : "newPin"
    "editpin/:id"  : "editPin"

  before: ->

    globalEvt = _.extend({}, Backbone.Events)

    view = new SampleApp.Views.Pins.PinListView(
      trip: @trip
      collection: @trip.pins
      day: 1
      el: $('#pin-panel')
      globalEvt: globalEvt
    )

    view = new SampleApp.Views.Pins.MapView({
      pins: @trip.pins
      el: $('#map')
      globalEvt: globalEvt
    })

    Backbone.history.start()

  show: ->
    @view.remove() if @view?

  edit: ->
    @view = new SampleApp.Views.Trips.EditView(collection: @trips)
    $("body").append(@view.render().el)

  newPin: (type) ->
    @view.remove() if @view?
    @view = new SampleApp.Views.Pins.NewView(
      trip: @trip
      collection: @trip.pins
      type: type
    )
    $("#right-container").html(@view.render().el)


  editPin: (pin_id) ->
    @view.remove() if @view?
    @view = new SampleApp.Views.Pins.ShowView(
      trip: @trip
      collection: @trip.pins
      model: @trip.pins.get(pin_id)
    )
    $("#right-container").html(@view.render().el)



