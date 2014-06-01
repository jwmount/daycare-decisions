// Initialize Angular App
var app = angular.module("app", ['ngRoute', 'ngAnimate', 'ngSanitize', 'autocomplete']);


// Set Config Variables
// var server = "http://localhost:8082/providers/1";
app.server = "http://daycare-decisions.herokuapp.com/api";
app.locations_api_call = app.server + "/locations/";
app.providers_api_call = app.server + "/providers/";

// Set headers for CORS
app.config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
    }
]);


// Routes
// -------------------------------
app.config(function($routeProvider) {
    $routeProvider.when('/', {
        // Home
        templateUrl: "home.html",
        controller: "HomeController"
    })
    .when('/about', {
        // ABOUT
        templateUrl: "about.html"
        // controller: "AboutController"
    })
    .when('/contact', {
        // ABOUT
        templateUrl: "contact_us.html"
        // controller: "contact_usController"
    })
    .when('/facts', {
        // FactSheets
        templateUrl: "fact_sheets.html"
        // controller: "fact_sheetsController"
    })
    .when('/faq', {
        // FAQ
        templateUrl: "faq.html"
        // controller: "FaqController"
    })
    .when('/newsletter', {
        // Newsletter
        templateUrl: "newsletter.html"
        // controller: "newsletterController"
    })
    .when('/privacy', {
        // Privacy
        templateUrl: "privacy_policy.html"
        // controller: "privacyController"
    })
    .when('/providers', {
        // Providers
        templateUrl: "provider_services.html"
        // controller: "provider_servicesController"
    })
    .when('/research', {
        // Research
        templateUrl: "research.html"
        // controller: "researchController"
    })
    .when('/terms_conditions', {
        // Terms & Conditions
        templateUrl: "terms_conditions.html"
        // controller: "terms_conditionsController"
    })
    .otherwise({
        // Anything Else
        redirectTo: '/'
    });
});



// Controllers
// -------------------------------

// Locations Controller
app.controller("HomeController", function($scope, $http, $timeout) {

    // Fires whenever key is clicked in form.locality field
    // We want to make the API call only when we have two chars in
    // in the form.locality field. After we have that initial list,
    // the autocomplete field further filters the list locally -- no
    // need for another API call.

    $scope.iterProvider = function(provider) {
      $scope.list = Object.keys(provider);
    }

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


// Helper function (experimental)
toggleChosenAttribute = function(obj) {
  console.log('prop: chosen');
}
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

