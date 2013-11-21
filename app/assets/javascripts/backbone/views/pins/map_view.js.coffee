SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.MapView extends Backbone.View
  #template: JST["backbone/templates/pins/pin"]

  constructor: (options) ->
    super(options)
    @pins = options.pins
    @pins.bind("add", @addPin, this)
    @pins.bind("remove", @removePin, this)

  render: ->
    console.log(@pins)
    jQuery ($) ->

      # Make the following global variables
    map = null
    pins = @pins
    self = this
    init = () ->
      # Setup map options
      mapOptions =

        center: new google.maps.LatLng(23, 121)
        zoom: 11
        disableDefaultUI: true
        mapTypeId: google.maps.MapTypeId.ROADMAP
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.SMALL
        mapTypeControlOptions:
          mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']

      # Create the map with above options in div
      self.map = new google.maps.Map(document.getElementById("map"),mapOptions)

      bounds = new google.maps.LatLngBounds

      _.each(pins.models, (pin) ->
        bounds.extend(new google.maps.LatLng(pin.get('latitude'), pin.get('longitude')))
        self.addPinToMap(pin)
      )

      self.map.fitBounds(bounds)

    init()

    return this

  addPinToMap: (pin) ->
    marker = new google.maps.Marker
      #animation: google.maps.Animation.DROP
      position: new google.maps.LatLng(pin.get('latitude'), pin.get('longitude'))
      map: @map
      pin: pin
      #draggable: true
    google.maps.event.addListener marker, 'click', ->
      infowindow = new google.maps.InfoWindow
      infowindow.setContent(pin.get('title'))
      infowindow.open(@map, @)
    pin.marker = marker

  addPin: (pin) ->
    @addPinToMap(pin)
    @map.setCenter (new google.maps.LatLng(pin.get('latitude'), pin.get('longitude')))

  removePin: (pin) ->
    pin.marker.setMap(null)
    pin.marker = null