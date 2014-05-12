// Set Config Variables
// var server = "http://localhost:8080/providers/1";
var server = "http://daycare-decisions.herokuapp.com/api";

// Initialize Angular App
var app = angular.module("app", ['autocomplete', 'ngSanitize']);

app.config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
    }
]);


// Locations Controller
app.controller("locationsCtrl", function($scope, $http) {
var locations_api_call = server + "/locations/";

    $scope.updateLocations = function() {
        if ($scope.selectedLocation.length < 2 ){
            return;
        }
        $http
            .get(locations_api_call + String($scope.selectedLocation))
            .success(function(data) {
                $scope.locations = data;
                console.log(data);
            })
            .error(function (data) {
                console.log(data)
            });
        };




    // --> https://github.com/JustGoscha/allmighty-autocomplete


});
