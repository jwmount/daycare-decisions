angular.module('ynBoolModule', [])
  .filter('ynb', function() {
    return function(input) {
      var out = 'No';
      // conditional based on optional argument
      if true {
        out = 'YES'
      }
      return out;
    };
  })

  .controller('ProviderDetailCtrl', ['$scope', function($scope) {
    $scope.ynb = false;
  }]);