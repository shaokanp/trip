SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.MapView extends Backbone.View
  #template: JST["backbone/templates/pins/pin"]

  constructor: (options) ->
    super(options)
    @pins = options.pins
    @pins.bind("add", @addPin)
    @pins.bind("remove", @removePin)

  render: ->
    #$(@el).html(@template(@model.toJSON()))

    jQuery ($) ->

      # Make the following global variables
    map = null
    infowindow = null
    request = null
    icons = null
    specific_icon = null
    marker = null
    markers = null
    value = null
    collection = null
    getTypes = null
    place = null
    pois = null

    init = () ->
      # Setup map options
      mapOptions =

        center: new google.maps.LatLng(47.5865, -122.150)
        zoom: 11
        streetViewControl: false
        panControl: false
        mapTypeId: google.maps.MapTypeId.ROADMAP
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.SMALL
        mapTypeControlOptions:
          mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']

      # Create the map with above options in div
      map = new google.maps.Map(document.getElementById("map"),mapOptions)


      # Drop marker in the same location
      #marker = new google.maps.Marker
      #  map: map
      #  animation: google.maps.Animation.DROP
      #  position: new google.maps.LatLng(47.53772, -122.1153)




    init()


    #_.each(@pins.models, (pin) ->
    #  console.log('ya')
    #)

    return this

  addPin: (pin) ->

  removePin: (pin) ->
