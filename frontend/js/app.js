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
var list_is_current = false;

    // Fires whenever key is clicked in selectedLocation field
    // We want to make the API call only when we have two chars in
    // in the selectedLocation field. After we have that initial list,
    // the autocomplete field further filters the list locally -- no
    // need for another API call.
    $scope.updateLocations = function() {
        // Less than two chars?
        if ($scope.selectedLocation.length < 2 ){
            // Clear locations list and don't do API call
            $scope.locations = [];
            list_is_current = false;
            return;
        }
        // More than two chars and locations list is not current?
        if ($scope.selectedLocation.length >= 2 && !list_is_current)
        $http
            .get(locations_api_call + String($scope.selectedLocation))
            .success(function(data) {
                $scope.locations = data;
                list_is_current = true;
                console.log(data);
            })
            .error(function (data) {
                console.log(data)
            });
        };

    // --> https://github.com/JustGoscha/allmighty-autocomplete


});
