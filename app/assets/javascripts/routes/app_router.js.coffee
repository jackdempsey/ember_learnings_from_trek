EmberLearnings.Router = Ember.Router.extend
  location: 'hash'

  root: Ember.Route.extend
    index: Ember.Route.extend
      route: '/'

      # You'll likely want to connect a view here.
      connectOutlets: (router) ->
        router.get('applicationController').connectOutlet('allContributors', [{login:'wycats'},{login:'tomdale'}])

      # Layout your routes here...
