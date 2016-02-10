/*globals angular */
angular.module('myApp').controller("mainCtl", function ($scope, DemoService) {
  'use strict';
  $scope.init = function () {
    console.log("I'm the init of mainCtl");
    $scope.ng = 'Angular';
    $scope.status = DemoService.status;
  };
});