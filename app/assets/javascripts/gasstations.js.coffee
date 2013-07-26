app = angular.module("Gasstations", ["ngResource"])

@GasstationCtrl = ($scope, $resource) ->
  $scope.asd = "qwe"
  Station = $resource("/stations/:id", {id: "@id"})
  $scope.stations = Station.query

  