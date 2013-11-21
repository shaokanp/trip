SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin_cell/pin"]

  events:
    "click": "edit"
    "click .destroy" : "destroy"

  tagName: "li"
  className: "pin-cell"

  constructor: (options) ->
    super(options)
    @model.bind("change:errors", () =>
      this.render()
    )

    $(@el).attr('pin-type', SampleApp.Models.Pin.pinType.MEETING);
    $(@el).attr('id', 'pin_' + @model.id);

  destroy: () ->
    @model.destroy(
      success: =>
        console.log('delete')
        this.remove()
    )

    return false

  render: ->
    json = @model.toJSON()
    $(@el).html(@template(json))
    return this

  hightlight: ->


  edit: ->
    window.location.hash = "editpin/#{@model.id}"

class SampleApp.Views.Pins.PinListView extends Backbone.View

  events:
    "click .new-pin-btn": "newPin"

  initialize: (options) ->
    @collection.bind('add', @addPin, this)
    @collection.bind('reset', @render, this)
    $(@el).children('#pin-container').sortable(
      update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
    )

  render: ->
    $(@el).children('#pin-container').html('')
    self = this
    _.each(@collection.models, (pin) ->
       self.addPin(pin)
    )
    return this

  addPin: (pin) ->
    $(@el).children('#pin-container').append(new SampleApp.Views.Pins.PinView(model: pin).render().el)

  newPin: (e) ->
    window.location.hash = 'newpin/'+$(e.target).attr('pin-type')