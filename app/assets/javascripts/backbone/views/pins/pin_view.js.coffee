SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin"]

  events:
    "click": "hightlight"
    "dblclick": "edit"
    "click .destroy" : "destroy"

  tagName: "li"
  className: "pin-cell"

  constructor: (options) ->
    super(options)

    @model.bind("change:errors", () =>
      this.render()
    )

  destroy: () ->
    @model.destroy(
      success: =>
        console.log('delete')
        this.remove()
    )

    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    console.log(@el)
    return @el

  hightlight: ->


  edit: ->
    window.location.hash = "#{@model.id}"

class SampleApp.Views.Pins.PinListView extends Backbone.View

  initialize: (options) ->
    @collection.bind('add', @addPin)
    #@collection.bind('reset', @render)

  render: ->
    $(@el).html('')
    self = this
    _.each(@collection.models, (pin) ->
       self.addPin(pin)
    )
    return this

  addPin: (pin) ->
    console.log(pin)
    $(@el).append(new SampleApp.Views.Pins.PinView(model: pin).render())

#    if pin.get('title') is 'rrr'
#      console.log('ggg');
#    else
#      $(@el).append(new SampleApp.Views.Pins.PinView(model: pin).render().el)

    console.log($(@el).children())