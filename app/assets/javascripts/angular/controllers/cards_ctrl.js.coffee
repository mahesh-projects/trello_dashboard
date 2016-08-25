App.controller 'CardsCtrl', ['$scope', 'Card', ($scope, Card) ->
  $scope.cards = Card.query()
]