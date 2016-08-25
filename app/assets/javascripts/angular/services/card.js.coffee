App.factory 'Card', ['$resource', ($resource) ->
  $resource '/api/cards'
]