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

    @globalEvt = options.globalEvt
    @globalEvt.on('day:change', @render, @)
    @listenTo(@collection, 'add', @addPin)
    @listenTo(@collection, 'reset', @render)

    @days = new Array

    @loadPins(options.day)
    window.day = options.day

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

  render: (day) ->
    $(@el).children('#pin-container').html('')
    self = @
    _.each(@collection.models, (pin) ->
      if day != undefined
        if pin.get('day') == day
          self.addPin(pin)
      else
        self.addPin(pin)
    )
    return this

  addPin: (pin) ->
    $(@el).children('#pin-container').append(new SampleApp.Views.Pins.PinView(model: pin).render().el)

  loadPins: (day) ->
    self = @
    @collection.fetch(
      data:
        trip_id: @trip.id
        day_id: day
      remove: false
      processData: true
      success: (collection,response,options) ->
        console.log('load pins success')
        self.days.push(day)
        self.globalEvt.trigger('day:change', day)
      error: (collection,response,options) ->
        console.log('load pins error')
    )

  newPin: (e) ->
    window.location.hash = 'newpin/'+$(e.target).attr('pin-type')

  changeDay: (e) ->
    index = $(@el).children('#day-navigator').children().index(e.target)
    if index == 0
      window.day = window.day - 1
      if window.day < 1
        window.day = 1
    else
      window.day = window.day + 1

    #Check if the day has been reached before. If it is, then don't need to fetch the pins again.
    if @days.indexOf(window.day) == -1
      @loadPins(window.day)
    else
      @globalEvt.trigger('day:change', window.day)
