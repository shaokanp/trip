SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinListView extends Backbone.View

  events:
    "click #new-pin-btn": "newPin"
    "click #day-navigator .nav-btn": "changeDay"

  initialize: (options) ->
    @trip = options.trip

    window.globalEvt.on('day:change', @render, @)
    @listenTo(@collection, 'add', @addPin)
    @listenTo(@collection, 'reset', @render)

    @days = new Array

    @loadPins(options.day)
    window.day = options.day

    self = @
    $(@el).find('#pin-container ul').sortable(
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
    $(@el).find('#pin-container ul').html('')
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
    $(@el).find('#pin-container ul').append(new SampleApp.Views.Pins.PinView(model: pin).render().el)

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
        window.globalEvt.trigger('day:change', day)
      error: (collection,response,options) ->
        console.log('load pins error')
    )

  newPin: (e) ->
#    window.location.hash = 'newpin/'+$(e.target).attr('pin-type')
    model  = new SampleApp.Models.Pin()
    model.position = @collection.length
    model.set('trip_id',@trip.id)

    @collection.add(model)

  changeDay: (e) ->
    index = $(@el).children('#day-navigator').children().index(e.target)
    ori = window.day
    if index == 0
      window.day = window.day - 1
      if window.day < 1
        window.day = 1
    else
      window.day = window.day + 1

    if ori != window.day
      window.location.hash = ''
      #Check if the day has been reached before. If it is, then don't need to fetch the pins again.
      if @days.indexOf(window.day) == -1
        @loadPins(window.day)
      else
        window.globalEvt.trigger('day:change', window.day)
