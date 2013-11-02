class SampleApp.Routers.TripsRouter extends Backbone.Router
  initialize: (options) ->
    @trip = new SampleApp.Models.Trip()
    @trip.set options.trip
    @trip.pins.reset(options.trip.pins)
    @isFirstShow = true
  routes:
    ""      : "show"
    "edit" : "edit"
    "newpin"   : "newPin"
    "editpin/:id"  : "editPin"

  show: ->
    @view.remove() if @view?
    if @isFirstShow
      console.log('show')
      @view = new SampleApp.Views.Pins.PinListView(
        model: @trip.pins
        el: $('#pin-container')
      )
      @view.render()
      @isFirstShow = false


  edit: ->
    @view = new SampleApp.Views.Trips.EditView(model: @trip)
    $("#trips").html(@view.render().el)

  newPin: ->
    @view = new SampleApp.Views.Pins.NewView(
      trip: @trip,
      collection: @trip.pins
    )
    $("body").append(@view.render().el)

  editPin: (id) ->


