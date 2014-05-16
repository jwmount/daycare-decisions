// Initialize Angular App
var app = angular.module("app", ['autocomplete', 'ngSanitize']);


// Set Config Variables
// var server = "http://localhost:8080/providers/1";
app.server = "http://daycare-decisions.herokuapp.com/api";
app.locations_api_call = app.server + "/locations/";
app.providers_api_call = app.server + "/providers/";


// Set headers for CORS
app.config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
    }
]);


// Locations Controller
app.controller("formCtrl", function($scope, $http) {

    // Fires whenever key is clicked in form.locality field
    // We want to make the API call only when we have two chars in
    // in the form.locality field. After we have that initial list,
    // the autocomplete field further filters the list locally -- no
    // need for another API call.

    // Update Locations  # --> https://github.com/JustGoscha/allmighty-autocomplete
    var list_is_current = false;
    $scope.updateLocations = function() {
        console.log('list_is_current: ' + list_is_current);
        // Less than two chars?
        if ($scope.form.locality.length < 2 ){
            // Clear locations list and don't do API call
            list_is_current = false;
            $scope.locations = [];
            return;
        }
        // More than two chars and locations list is not current?
        else if ($scope.form.locality.length >= 2 && !list_is_current) {
            $http
            .get(app.locations_api_call + String($scope.form.locality))
            .success(function(data) {
                $scope.locations = data;
                list_is_current = true;
                // console.log(data);
            })
            .error(function (data) {
                // console.log(data)
            });
        }
    };

    // Update Providers
    $scope.updateProviders = function(suggestion) {
        var params = $scope.form;
        if (suggestion)
            params.locality = suggestion;
        // console.log(params);
        $http({ method: 'GET', url: app.providers_api_call, params: params })
            .success(function(data) {
                $scope.providers = data;
                // console.log(data);
            })
            .error(function (data) {
                // console.log(data)
            });
    }
});

