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

  onPinDestroyed: ->
    @remove()

  render: ->
#    this.$('#pin-info-container').html(new SampleApp.Views.Pins.InfoView(
#      trip: @trip
#      model: @model
#      mode:'display'
#    ).render().el)

    #$("#right-container").html(@el)
    if @noteListView?
      @noteListView.switchToModel(@model)
    else
      $(@el).html(@template())
      @noteListView = new SampleApp.Views.Notes.NoteListView(
        trip: @trip
        pin: @model
        collection: @model.notes
      )
      $(@el).prepend(@noteListView.el)

    return this
