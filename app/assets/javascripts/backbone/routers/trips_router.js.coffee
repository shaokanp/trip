class SampleApp.Routers.TripsRouter extends Backbone.Router
  initialize: (options) ->
    @trip = new SampleApp.Models.Trip()
    @trip.set options.trip

    @before()

  routes:
    "": "show"
    "edit": "edit"
    "newpin/:type": "newPin"
    "pins/:id": "showPinNoteList"
    "pins/:pin_id/notes/:note_id": "showNote"

  before: ->
    window.router = @
    window.globalEvt = _.extend({}, Backbone.Events)
    @listenToOnce(@trip.pins, 'sync', ->
      Backbone.history.start()
    )

    view = new SampleApp.Views.Pins.PinListView(
      trip: @trip
      collection: @trip.pins
      day: 1
      el: $('#pin-panel')
    )

    view = new SampleApp.Views.Pins.MapView({
      pins: @trip.pins
      el: $('#map')
    })

  show: ->
    @view.remove() if @view?
    if @noteListView?
      @noteListView.remove()
      @noteListView = null
    if @noteView?
      @noteView.remove()
      @noteView = null

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


  showPinNoteList: (pin_id) ->
    if @noteView?
      @noteView.remove()
      @noteView = null
    if @noteListView?
      @noteListView.switchToModel(@trip.pins.get(pin_id))
      @noteListView.render()
    else
      @noteListView = new SampleApp.Views.Pins.ShowView(
        trip: @trip
        collection: @trip.pins
        model: @trip.pins.get(pin_id)
      )
      $("#right-container").html(@noteListView.render().el)

  showNote: (pin_id, note_id) ->
    if !(@noteListView?)
      temp = @noteView
      @noteView = undefined
      @showPinNoteList(pin_id)
      @noteView = temp

    noteModel = undefined
    if note_id == 'new'
      noteModel = @trip.pins.get(pin_id).notes.findWhere(id:undefined)
    else
      noteModel = @trip.pins.get(pin_id).notes.get(note_id)

    if @noteView? && $('#note-container').children().length > 0
      @noteView.switchToModel(noteModel)
      @noteView.render()
    else
      @noteView = new SampleApp.Views.Notes.ShowView(
        pin: @trip.pins.get(pin_id)
        model: noteModel
      )
      $("#note-container").html(@noteView.render().el)


