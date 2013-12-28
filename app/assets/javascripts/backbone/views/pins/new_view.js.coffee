SampleApp.Views.Pins ||= {}

# just a container of the pin info view
class SampleApp.Views.Pins.NewView extends Backbone.View
  template: JST["backbone/templates/pins/show"]

  attributes:
    id: 'pin-content-container'

  tagName: 'div'

  constructor: (options) ->
    super(options)
    @trip = options.trip;
    @model = new SampleApp.Models.Pin()
    @model.set('pin_type', options.type)
    @listenTo(@model, 'sync', @onPinCreated)

#  save: (e) ->
#    e.preventDefault()
#    e.stopPropagation()
#
#    @model.unset("errors")
#    @model.set('trip_id', @trip.id)
#
#    @collection.create(@model.toJSON(),
#      wait: true
#      success: (pin) =>
#        window.location.hash = ''
#      error: (pin, jqXHR) =>
#        @model.set(errors: $.parseJSON(jqXHR.responseText))
#    )

  onPinCreated: ->
    console.log(this)
    console.log(@collection)
    console.log(@model)
    @collection.add(@model)
    window.location.hash = 'editpin/' + @model.id

  render: ->
    $(@el).html(@template())
    this.$('#pin-info-container').html(new SampleApp.Views.Pins.InfoView(
      trip: @trip
      model: @model
      mode:'new'
    ).render().el)

    return this
