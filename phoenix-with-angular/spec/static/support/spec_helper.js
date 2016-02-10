/*globals document, window, angular, $ */

(function () {
  'use strict';
  var meta = document.createElement("META");
  meta.setAttribute('name', 'csrf_token');
  meta.setAttribute('content', 'csrf');

  document.head.appendChild(meta);

  window.mockController = function (ng_app_name, controller_name) {
    var scope, controller, module;

    module = angular.mock.module(ng_app_name);
    angular.mock.inject(function ($rootScope, $controller) {
      scope = $rootScope.$new();
      controller = $controller(controller_name, {
        $scope: scope,
        $element : angular.element('<div></div>')
      });
    });
    return {
      module: module,
      controller: controller,
      scope: scope,
    };
  };
}());