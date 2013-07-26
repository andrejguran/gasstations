app = angular.module("Gasstations", ["ngResource"]);

app.factory "Station", ["$resource", ($resource) ->
  $resource("/stations/:id", {id: "@id"})
]

@GasstationCtrl = ["$scope", "Station", ($scope, Station) ->
  $scope.stations = Station.query()
]