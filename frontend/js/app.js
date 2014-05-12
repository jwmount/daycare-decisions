// Set Config Variables
// var server = "http://localhost:8080/providers/1";
var server = "http://daycare-decisions.herokuapp.com/api";

// Initialize Angular App
var app = angular.module("app", ['autocomplete', 'ngSanitize']);

// app.config(['$httpProvider', function($httpProvider) {
//         $httpProvider.defaults.useXDomain = true;
//         delete $httpProvider.defaults.headers.common['X-Requested-With'];
//     }
// ]);


// Locations Controller
app.controller("locationsCtrl", function($scope, $http) {

    updateLocations = function() { alert('hi') };

    locations_api_call = server + "/locations/a";
    console.log(locations_api_call);
    $http
        .get(locations_api_call)
        .success(function(data) {
            $scope.locations = data;
            console.log(data);
        })
        .error(function (data) {
            console.log(data)
        });

    // $scope.locations = [
    //     "Adelaide, SA",
    //     "Mount Barker, SA",
    //     "Mount Gambier, SA",
    //     "Murray Bridge, SA",
    //     "Port Adelaide, SA",
    //     "Port Augusta, SA",
    //     "Port Pirie, SA",
    //     "Port Lincoln, SA",
    //     "Victor Harbor, SA",
    //     "Whyalla, SA",
    //     "Brisbane, QLD",
    //     "Bundaberg, QLD",
    //     "Cairns, QLD",
    //     "Caloundra, QLD",
    //     "Gladstone, QLD",
    //     "Gold Coast, QLD",
    //     "Gympie, QLD",
    //     "Hervey Bay, QLD",
    //     "Ipswich *, QLD",
    //     "Logan City *, QLD",
    //     "Mackay, QLD",
    //     "Maryborough, QLD",
    //     "Mount Isa, QLD",
    //     "Rockhampton, QLD",
    //     "Sunshine Coast, QLD",
    //     "Toowoomba, QLD",
    //     "Townsville, QLD",
    //     "Sydney, NSW",
    //     "Albury, NSW",
    //     "Armidale, NSW",
    //     "Bathurst, NSW",
    //     "Blue Mountains, NSW",
    //     "Broken Hill, NSW",
    //     "Campbelltown *, NSW",
    //     "Cessnock, NSW",
    //     "Dubbo, NSW",
    //     "Goulburn, NSW",
    //     "Grafton, NSW",
    //     "Lithgow, NSW",
    //     "Liverpool *, NSW",
    //     "Newcastle, NSW",
    //     "Orange, NSW",
    //     "Parramatta *, NSW",
    //     "Penrith *, NSW",
    //     "Queanbeyan, NSW",
    //     "Tamworth, NSW",
    //     "Wagga Wagga, NSW",
    //     "Wollongong, NSW"
    // ];

    // --> https://github.com/JustGoscha/allmighty-autocomplete


});
