/*globals angular*/
angular.module('myApp').factory('DemoService', [
  function () {
    'use strict';
    console.log("I'm the DemoService");
    var service = {};

    service.status = 'works';

    return service;
  }]);
