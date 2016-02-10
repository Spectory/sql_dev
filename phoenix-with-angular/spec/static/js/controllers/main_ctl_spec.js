/*globals _, describe, unused , it, expect, beforeEach, angular, mock, module, $controller, document, window, mockController */

describe('homeCtl,', function () {
  'use strict';

  var controller, scope, module;

  beforeEach(function () {
    var mocked_controller = mockController('myApp', 'mainCtl');
    controller = mocked_controller.controller;
    scope = mocked_controller.scope;
    module = mocked_controller.module;
  });

  it("should be a valid module", function () {
    expect(controller).toBeDefined();
    expect(scope).toBeDefined();
  });

  describe('init', function () {
    beforeEach(function () {scope.init(); });
    it('should init the scope', function () {
      expect(scope.ng).toEqual('Angular');
      expect(scope.status).toEqual('works');
    });
  });

});