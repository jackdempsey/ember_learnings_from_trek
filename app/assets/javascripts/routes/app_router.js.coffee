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
      connectOutlets: (router, context) ->
        router.get('applicationController').connectOutlet('oneContributor', context)

      serialize: (router, context) ->
        githubUserName: context.get 'login'

      deserialize: (router, urlParams) ->
        EmberLearnings.Contributor.findOne urlParams.githubUserName

      showDetails: Ember.Route.transitionTo 'details'
      showRepos: Ember.Route.transitionTo 'repos'
      showAllContributors: Ember.Route.transitionTo 'contributors'

      initialState: 'details'

      details: Ember.Route.extend
        route: '/'
        connectOutlets: (router) ->
          router.get('oneContributorController.content').loadMoreDetails()
          router.get('oneContributorController').connectOutlet 'details'
      repos: Ember.Route.extend
        route: '/repos'
        connectOutlets: (router) ->
          router.get('oneContributorController.content').loadRepos()
          router.get('oneContributorController').connectOutlet 'repos'


