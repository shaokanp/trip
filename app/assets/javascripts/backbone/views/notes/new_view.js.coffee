SampleApp.Views.Notes ||= {}

class SampleApp.Views.Notes.NewView extends Backbone.View
  template: JST["backbone/templates/notes/new"]

  events:
    "click #submit-new-note-btn": "save"

  tagName: 'div'

  attributes:
    class: 'note-view'

  constructor: (options) ->
    super(options)
    @pin = options.pin
    #@model.bind('change', 'noteChanged', this)
    @model = new SampleApp.Models.Note(
      pin_id: @pin.id
    )
    @model.bind('save', 'noteSaved', this)
    @model.bind('destroy', 'noteDestroyed', this)

    console.log(@model.toJSON())
    console.log(@collection)

  save: ->
    @model.unset("errors")
    console.log("going to send")
    console.log(@model.toJSON())
    this.$('input[name="authenticity_token"]').val($("meta[name='csrf-token']").attr("content"))
    this.$('input[name="pin_id"]').val(@model.get('pin_id'))
    console.log('haha' + this.$('form').serializeArray())
#    $.ajax(
#      type: 'POST',
#      url: this.$('form').attr('action'),
#      enctype: 'multipart/form-data',
#      data:
#        note:
#          pin_id: @model.get('pin_id')
#          content: this.$('input[name="content"]').val()
#          authenticity_token: this.$('input[name="authenticity_token"]').val()
#          image: this.$('input[name="image"]').val()
#      success: ->
#        console.log('create note success')
#    )

    @collection.create(@model.toJSON(),
      wait: true
      success: (note) =>
        console.log("note created")
      error: (pin, jqXHR) =>
        @model.set(errors: $.parseJSON(jqXHR.responseText))
    )

  noteChanged: ->


  noteSync: ->


  noteDestroyed: ->
    @remove()

  render: ->
    $(@el).html(@template())
    this.$('form').backboneLink(@model)

    this.$('form').bind('ajax:success', ->
      console.log('success');
    )
    this.$('form').bind('ajax:error', ->
      console.log('error');
    )

    return this
