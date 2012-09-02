EmberLearnings.Contributor = Ember.Object.extend()
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

