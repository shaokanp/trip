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
    @model.bind('destroy', 'onPinDestroyed', this)

  onPinDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template())

    this.$('#pin-info-container').html(new SampleApp.Views.Pins.InfoView(
      trip: @trip
      model: @model
      mode:'display'
    ).render().el)

    console.log(@model.notes)
    this.$('#pin-note-container').html(new SampleApp.Views.Notes.NoteListView(
      trip: @trip
      pin: @model
      collection: @model.notes
    ).render().el)

    return this
