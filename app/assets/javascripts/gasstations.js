app = angular.module("Gasstations", ["ngResource"]);

app.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/', {templateUrl: '/all.html',   controller: 'GasstationCtrl'}).
      when('/:id', {templateUrl: '/show.html', controller: GasstationCtrl});
}]);

app.factory("Station", ["$resource", function($resource) {
  return $resource("/stations/:id", {id: "@id"});
}]);

GasstationCtrl = ["$scope", "$routeParams", "Station", function($scope, $routeParams, Station) {
  if ($routeParams.id) {
    $scope.station = Station.get({id: $routeParams.id});
    $scope.ants = $scope.station.entries
  } else {
    $scope.stations = Station.query();
  }
}];
