SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.ImageView extends Backbone.View

  events:
    "click": 'showImage'

  tagName: 'img'

  attributes:
    class: 'note-image'

  constructor: (options) ->
    super(options)

    @src = options.src


  imageDestroyed: ->
    @remove()

  render: ->
    $(@el).attr('src', @src)
    console.log(@el)

    return this

  showImage: ->
