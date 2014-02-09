SampleApp.Views.Pins ||= {}

# just a container of the pin info view
class SampleApp.Views.Pins.ShowView extends Backbone.View
  template: JST["backbone/templates/pins/show"]

  attributes:
    id: 'pin-content-container'

  tagName: 'div'

  constructor: (options) ->
    super(options)
    @trip = options.trip
    @switchToModel(@model)

  switchToModel: (model) ->
    if !(model?)
      return
    @stopListening(@model) if @model?
    @model = model
    @listenTo(@model, 'destroy', @onPinDestroyed)
    @render()

  onPinDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template())

#    this.$('#pin-info-container').html(new SampleApp.Views.Pins.InfoView(
#      trip: @trip
#      model: @model
#      mode:'display'
#    ).render().el)

    $("#right-container").html(@el)
    if @noteListView?
      @noteListView.switchToModel(@model)
    else
      @noteListView = new SampleApp.Views.Notes.NoteListView(
        trip: @trip
        pin: @model
        collection: @model.notes
        el: $(@el).children('#note-list-container')
      )

    return this
