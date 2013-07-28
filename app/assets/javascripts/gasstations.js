app = angular.module("Gasstations", ["ngResource"]);

app.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: '/index',   controller: 'GasstationCtrl'}).
      when('/:id', {templateUrl: '/show', controller: GasstationCtrl});
}]);

app.factory("Station", ["$resource", function($resource) {
  return $resource("/stations/:id", {id: "@id"});
}]);

GasstationCtrl = ["$scope", "$routeParams", "Station", function($scope, $routeParams, Station) {
  if ($routeParams.id) {
    $scope.stations = Station.get({id: $routeParams.id});
  } else {
    $scope.stations = Station.query();
  }
}];
