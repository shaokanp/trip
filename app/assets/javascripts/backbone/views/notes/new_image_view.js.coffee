SampleApp.Views.Trips ||= {}

class SampleApp.Views.Notes.NewImageView extends Backbone.View
  template: JST["backbone/templates/notes/new_image"]

  events:
    #"click #upload-image-btn": "save"
    "click #cancel-upload-btn": "cancel"

  tagName: 'div'

  attributes:
    id: 'note-upload-image-form-container'

  constructor: (options) ->
    super(options)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    console.log(@model)

    @model.save(@model.toJSON(),
      wait: true
      success: (note) =>
        console.log("note edited")

      error: (note, jqXHR) =>
        self.model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  cancel: ->
    @remove()

  render: ->
    $(@el).html(@template(@model.toJSON()))

    #$(@el).children("form").backboneLink(@model)

    return this
