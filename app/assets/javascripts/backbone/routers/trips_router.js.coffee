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
    self = @
    @trip.pins.fetch(
      data:
        trip_id: @trip.id
        day_id: 1
      processData: true
      success: (collection,response,options) ->
        console.log('ooooo')

        view = new SampleApp.Views.Pins.PinListView(
          collection: self.trip.pins
          el: $('#pin-panel')
        )
        view.render()

        view = new SampleApp.Views.Pins.MapView({
          pins: self.trip.pins
          el: $('#map')
        })
        view.render()

        Backbone.history.start();

      error: (collection,response,options) ->
        console.log('eeeee')
    )



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



