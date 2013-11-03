SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.MapView extends Backbone.View
  #template: JST["backbone/templates/pins/pin"]

  constructor: (options) ->
    super(options)
    @pins = options.pins
    @pins.bind("add", @addPin)
    @pins.bind("remove", @removePin)

  render: ->
    console.log(@pins)
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
    pins = @pins
    init = () ->
      # Setup map options
      mapOptions =

        center: new google.maps.LatLng(40.6892494, -74.04450039999999)
        zoom: 11
        disableDefaultUI: true
        mapTypeId: google.maps.MapTypeId.ROADMAP
        zoomControlOptions:
          style: google.maps.ZoomControlStyle.SMALL
        mapTypeControlOptions:
          mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']

      # Create the map with above options in div
      map = new google.maps.Map(document.getElementById("map"),mapOptions)


      console.log(pins)
      _.each(pins.models, (pin) ->
        marker = new google.maps.Marker
        animation: google.maps.Animation.DROP
        position: new google.maps.LatLng(40.6892494, -74.04450039999999)#pin.get('latitude'), pin.get('longitude'))

      )


    init()




    return this

  addPin: (pin) ->

  removePin: (pin) ->
