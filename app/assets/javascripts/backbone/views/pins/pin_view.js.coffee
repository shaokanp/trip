SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin_cell/pin"]

  events:
    "click": "show"
    "click .pin-edit-btn": "edit"
    "click .pin-save-btn": "save"
    "click .pin-delete-btn" : "delete"

  tagName: "li"
  className: "pin-cell"

  state: 'display' # display, edit

  constructor: (options) ->
    super(options)

    if @model.isNew()
      @state = 'edit'
    @state = options.state if options.state?

    #@listenTo(@model,'change', @render)

#    $(@el).attr('pin-type', SampleApp.Models.Pin.pinType.attraction)
#    $(@el).attr('id', 'pin_' + @model.id)

  delete: () ->
    console.log(@model)
    self = this
    @model.destroy(
      wait: true
      success: =>
        console.log('delete')
        self.remove()
    )

    return false

  save: ->
    @model.unset("errors")
    console.log("going to send")
    console.log(@model.toJSON())

    self = this
    @model.save(@model.toJSON(),
      wait: true
      success: (note) =>
        console.log("pin created/edited")
        self.state = 'display'
        $(self.el).find('.pin-title').editable('hide')
        $(self.el).find('.pin-address').editable('hide')
        $(self.el).find('.pin-title').editable('disable')
        $(self.el).find('.pin-address').editable('disable')

      error: (note, jqXHR) =>
        self.model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  show: ->
    #window.location.hash = "editpin/#{@model.id}"
    if @model.id?
      window.location.hash = "pins/#{@model.id}"

  edit: ->
    @state = 'edit'
    $(@el).find('.pin-title').editable('enable')
    $(@el).find('.pin-address').editable('enable')
    $(@el).find('.pin-title').editable('show')
    $(@el).find('.pin-address').editable('show')

    searchBox = new google.maps.places.SearchBox($(@el).find('input').get(1))
    window.globalEvt.trigger('address_input:created', searchBox)

  render: ->
    json = @model.toJSON()
    $(@el).html(@template(json))

    @configEditable('.pin-title', 'title', 'Title', '', true)
    @configEditable('.pin-address', 'address', 'Address', '', true)

    if @state == 'edit'
      @edit()

    return this

  configEditable: (targetSelector, attr, placeholder, inputClass, disable) ->
    self = @

    $(@el).find(targetSelector).editable(
      mode:'inline'
      showbuttons: false
      placeholder: placeholder
      #inputclass: inputClass
      disabled: disable
      success: (resp, newValue) ->
        self.model.set(attr, newValue)
    )



