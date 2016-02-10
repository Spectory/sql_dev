/*globals describe, it, expect, beforeEach, angular, mock, module, inject, unused */
describe('demoService,', function () {
  'use strict';

  beforeEach(angular.mock.module('myApp'));

  var service;

  beforeEach(inject(function (DemoService) {
    service = DemoService;
  }));

  describe('functionality', function () {
    it('should be defined', function () {
      expect(service).toBeDefined();
      expect(service.status).toEqual('works');
    });
  });
});