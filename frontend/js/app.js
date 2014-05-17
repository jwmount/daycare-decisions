// Initialize Angular App
var app = angular.module("app", ['ngAnimate', 'ngSanitize', 'autocomplete']);


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
app.controller("formCtrl", function($scope, $http, $timeout) {

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
        // When updateProviders is called from checkboxes, the suggestion (city, state)
        // is already populated. But when it's called from the autocomplete on-select
        // directive, that event happens BEFORE the form is fully populated, so we
        // pass the <suggestion> arg directly from autocomplete.js
        if (suggestion)
            params.locality = suggestion;

        // Remove any explicit calls to items equal to "false"
        // (for example if a checkbox is checked, then unchecked)
        params = remove_false_attributes(params);

        console.log(params);
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


// Helper function
remove_false_attributes = function(obj) {
    for (var prop in obj) {
        // console.log('prop: ' + prop);
        // console.log('obj[prop]: ' + obj[prop]);
        if (obj.hasOwnProperty(prop) && obj[prop] === false)
            delete obj[prop];
    }
    return obj;
}

