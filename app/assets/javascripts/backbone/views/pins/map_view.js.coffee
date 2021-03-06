SampleApp.Views.Pins ||= {}

class SampleApp.Views.Pins.MapView extends Backbone.View
  template: JST["backbone/templates/map/info_window_content"]

  constructor: (options) ->
    super(options)
    @pins = options.pins
    @listenTo(@pins, "add", @addPin)
    @listenTo(@pins, "remove", @removePin)
    @listenTo(@pins, "change:move_origin", @updatePinPos)
    window.globalEvt.on('day:change', @render, @)
    window.globalEvt.on('address_input:created', @addAddressListener, @)

    @coordinates = new Array

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
    @map = new google.maps.Map(document.getElementById("map"),mapOptions)

    @bounds = new google.maps.LatLngBounds

    # new an array consisting each pin's coordinates

    @linePath = new google.maps.Polyline
      path: @coordinates
      geodesic: true
      strokeColor: '#FF0000'
      strokeOpacity: 0
      icons:[
        icon:
          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
          strokeWeight: 4
          strokeOpacity: 1
        offset: '100%'
      ,
        icon:
          path: 'M 0,-1 0,1'
          strokeOpacity: 1
          strokeWeight: 3
          scale: 4
        offset: '0'
        repeat: '18px'
      ]
      map: @map
  render: (day) ->

    # Make the following global variables
    pins = @pins
    self = @

    if @coordinates.length > 0
      _.each(pins.models, (pin) ->
        if pin.marker != undefined && pin.marker != null
          self.removePin(pin)
      )

    _.each(pins.models, (pin) ->
      if day != undefined
        if pin.get('day') == day
          self.addPinToMap(pin)
      else
        self.addPinToMap(pin)
    )
    @map.fitBounds(@bounds)

    return this

  addPinToMap: (pin) ->
    newLatLng = new google.maps.LatLng(pin.get('latitude'), pin.get('longitude'))
    @bounds.extend(newLatLng)

    marker = new google.maps.Marker
      #animation: google.maps.Animation.DROP
      position: new google.maps.LatLng(pin.get('latitude'), pin.get('longitude'))
      map: @map
      pin: pin

    # set info window
    content = @template(pin.toJSON())
    @infowindow = new google.maps.InfoWindow
    self = @
    google.maps.event.addListener marker, 'click', ->
      self.infowindow.close()
      self.infowindow.setContent(content)
      self.infowindow.open(@map, marker)

    pin.marker = marker
    @coordinates.push(marker.position)
    @linePath.setPath(@coordinates)

    if @pins.length - 1 == @pins.indexOf(pin)
      @map.fitBounds(@bounds)

  addPin: (pin) ->
    if pin.isNew
      return
    @addPinToMap(pin)
    @map.setCenter (new google.maps.LatLng(pin.get('latitude'), pin.get('longitude')))

  removePin: (pin) ->
    idx = @coordinates.indexOf(pin.marker.position)
    pin.marker.setMap(null)
    pin.marker = null
    @coordinates.splice(idx, 1)
    @linePath.setPath(@coordinates)

  updatePinPos: (pin) ->
    if pin.get('move_origin') == -1
      return
    old_idx = pin.get('move_origin')
    new_idx = pin.get('move_dest')
    # remove the coordinate from old position
    # and insert into the new position
    tmp = @coordinates.splice(old_idx,1)
    @coordinates.splice(new_idx,0,tmp[0])
    @linePath.setPath(@coordinates)
    # reset the attributes to -1
    pin.set('move_origin',-1)
    pin.set('move_dest',-1)

  addAddressListener: (searchBox) ->
    self = @
    google.maps.event.addListener(searchBox, 'places_changed', ->
      places = searchBox.getPlaces()

      #For each place, get the icon, place name, and location.
      bounds = new google.maps.LatLngBounds()

      _.each(places, (place) ->
        #Create a marker for each place.
        marker = new google.maps.Marker(
          map: self.map,
          title: place.name,
          position: place.geometry.location
        )

        bounds.extend(place.geometry.location)
      )

      self.map.fitBounds(bounds)
    )


