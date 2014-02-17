SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.PinView extends Backbone.View
  template: JST["backbone/templates/pins/pin_cell/pin"]

  events:
    "click .pin-edit-btn": "edit"
    "click .pin-save-btn": "save"
    "click .pin-delete-btn" : "delete"
    "click": "show"

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
    @model.set('title', @title_el.data().editable.input.$input.val())
    @model.set('address', @address_el.data().editable.input.$input.val())

    self = this
    @model.save(@model.toJSON(),
      wait: true
      success: (note) =>
        console.log("pin created/edited")

      error: (note, jqXHR) =>
        self.model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  show: ->
    #window.location.hash = "editpin/#{@model.id}"
    if @model.id?
      window.location.hash = "pins/#{@model.id}"

  edit: ->
    @state = 'edit'
    @title_el.editable('enable')
    @address_el.editable('enable')
    @title_el.editable('show')
    @address_el.editable('show')

#    console.log(@title_el.editable())
#    console.log(@title_el.data())
#    console.log(@title_el)

    searchBox = new google.maps.places.SearchBox($(@el).find('input').get(1))
    window.globalEvt.trigger('address_input:created', searchBox)

  display: ->
    @state = 'display'
    @title_el.editable('hide')
    @address_el.editable('hide')
    @title_el.editable('disable')
    @address_el.editable('disable')

  render: ->
    json = @model.toJSON()
    $(@el).html(@template(json))

    @title_el = $(@el).find('.pin-title')
    @address_el = $(@el).find('.pin-address')

    @configEditable(@title_el, 'title', 'Title', '', true)
    @configEditable(@address_el, 'address', 'Address', '', true)

    if @state == 'edit'
      @edit()


    return this

  configEditable: (target_el, attr, placeholder, inputClass, disable) ->
    self = @

    target_el.editable(
      mode:'inline'
      showbuttons: false
      placeholder: placeholder
      #inputclass: inputClass
      disabled: disable
      send: 'always'
      success: (resp, newValue) ->
        self.model.set(attr, newValue)
        console.log('setVal')
    )



