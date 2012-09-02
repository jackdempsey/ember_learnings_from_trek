EmberLearnings.Router = Ember.Router.extend
  location: 'hash'
  enableLogging: true

  root: Ember.Route.extend
    contributors: Ember.Route.extend
      route: '/'
      showContributor: Ember.Route.transitionTo 'aContributor'
      connectOutlets: (router) ->
        router.get('applicationController').connectOutlet('allContributors', EmberLearnings.Contributor.find())

    aContributor: Ember.Route.extend
      route: '/:githubUserName'
      showAllContributors: Ember.Route.transitionTo 'contributors'
      connectOutlets: (router, context) ->
        router.get('applicationController').connectOutlet('oneContributor', context)
      serialize: (router, context) ->
        githubUserName: context.get 'login'
      deserialize: (router, urlParams) ->
        EmberLearnings.Contributor.findOne urlParams.githubUserName
