class SampleApp.Models.User extends Backbone.Model
  paramRoot: 'user'
  urlRoot: '/users'

  defaults:
    admin: false
    avatar_url: ''
    email: ''
    name: ''
    password_digest: ''
    remember_token: ''

  initialize: ->
    @pins = new SampleApp.Collections.PinsCollection();

class SampleApp.Collections.UsersCollection extends Backbone.Collection
  model: SampleApp.Models.Trip
  url: '/users'
