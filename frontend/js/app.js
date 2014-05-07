// Set Config Variables
var server = "http://localhost:8080/providers/1";

// Initialize Angular App
var app = angular.module("app", ['autocomplete']);

// Providers Controller
app.controller("ProvidersCtrl", function($scope, $http) {
    $scope.locations = [123,234,345,456,567,678];

    // --> https://github.com/JustGoscha/allmighty-autocomplete

    // $http.get(server)
    // .success(function(data) {
    //     console.log(data);
    // });
});