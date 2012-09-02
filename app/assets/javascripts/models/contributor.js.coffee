EmberLearnings.Contributor = Ember.Object.extend
  loadRepos: ->
    $.ajax
      url: 'https://api.github.com/users/%@/repos'.fmt @get('login')
      context: this
      dataType: 'jsonp'
      success: (response) ->
       @set 'repos',response.data

  loadMoreDetails: ->
    $.ajax
      url: 'https://api.github.com/users/%@'.fmt @get('login')
      context: this,
      dataType: 'jsonp',
      success: (response) ->
        @setProperties response.data

EmberLearnings.Contributor.reopenClass
  allContributors: []
  find: ->
    $.ajax
      url: "https://api.github.com/repos/emberjs/ember.js/contributors"
      dataType: "jsonp"
      context: this
      success: (response) ->
        response.data.forEach ((contributor) ->
          @allContributors.addObject EmberLearnings.Contributor.create(contributor)
        ), this

    @allContributors

  findOne: (username) ->
    contributor = EmberLearnings.Contributor.create
      login: username

    $.ajax
      url: "https://api.github.com/repos/emberjs/ember.js/contributors"
      dataType: "jsonp"
      context: contributor
      success: (response) ->
        @setProperties response.data.findProperty "login", username

    contributor

