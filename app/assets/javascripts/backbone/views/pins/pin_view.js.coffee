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
    "click #day-navigator button": "changeDay"

  initialize: (options) ->
    @trip = options.trip

    @listenTo(@collection, 'add', @addPin)
    @listenTo(@collection, 'reset', @render)

    @loadPins(options.day)
    @day = options.day

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
      if pin.get('day_id') == self.day
        self.addPin(pin)
    )
    return this

  addPin: (pin) ->
    $(@el).children('#pin-container').append(new SampleApp.Views.Pins.PinView(model: pin).render().el)

  loadPins: (day) ->
    @collection.fetch(
      data:
        trip_id: @trip.id
        day_id: day
      processData: true
      success: (collection,response,options) ->
        console.log('load pins success')


      error: (collection,response,options) ->
        console.log('load pins error')
    )

  newPin: (e) ->
    window.location.hash = 'newpin/'+$(e.target).attr('pin-type')

  changeDay: (e) ->
    index = $(@el).children('#pin-container').index(e)
    if index == 1
      @day = @day - 1
      if @day < 1
        @day = 1
      @loadPins(@day)
    else
      @day = @day + 1
      @loadPins(@day)

