SampleApp.Views.Trips ||= {}

class SampleApp.Views.Notes.NewImageView extends Backbone.View
  template: JST["backbone/templates/notes/new_image"]

  events:
    "click #upload-image-btn": "save"
    "click #cancel-upload-btn": "cancel"

  tagName: 'div'

  attributes:
    id: 'note-upload-image-form-container'

  constructor: (options) ->
    super(options)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    this.$('input[name="authenticity_token"]').val($("meta[name='csrf-token']").attr("content"))
    $(@el).children("form").ajaxForm(
      data:
        id:@model.id
    ).submit()

  cancel: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    #$(@el).children("form").backboneLink(@model)

    return this
