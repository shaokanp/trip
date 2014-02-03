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
    @listenTo(@model,'change:errors', @render)

    $(@el).attr('pin-type', SampleApp.Models.Pin.pinType.MEETING);
    $(@el).attr('id', 'pin_' + @model.id);

  destroy: () ->
    console.log(@model)
    self = this
    @model.destroy(
      wait: true
      success: =>
        console.log('delete')
        self.remove()
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
    #"click ": "changeDay"

  initialize: (options) ->
    @listenTo(@collection, 'add', @addPin)
    @listenTo(@collection, 'reset', @render)

    self = @
    $(@el).children('#pin-container').sortable(
      start: (event, ui) ->
        $(this).attr('data-previndex', ui.item.index())
      update: (event, ui) ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
        target_id = ui.item.attr('id').replace("pin_", "")
        new_idx = ui.item.index()
        old_idx = $(this).attr('data-previndex')
        self.collection.get(target_id).set(
          move_origin: old_idx
          move_dest: new_idx
        )
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

  loadPins: (day) ->
    self = @
    @trip.pins.fetch(
      data:
        day_id: day
      processData: true
      success: (collection,response,options) ->
        console.log('load pins success')

        view = new SampleApp.Views.Pins.PinListView(
          collection: @trip.pins
          el: $('#pin-panel')
        )
        view.render()

        view = new SampleApp.Views.Pins.MapView({
          pins: @trip.pins
          el: $('#map')
        })
        view.render()

      error: (collection,response,options) ->
        console.log('load pins error')
    )

  newPin: (e) ->
    window.location.hash = 'newpin/'+$(e.target).attr('pin-type')

  changeDay: (e) ->
