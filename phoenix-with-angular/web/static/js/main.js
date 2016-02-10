/*globals angular, document */

angular.module('myApp', []);

angular.module('myApp').config(function ($httpProvider) {
  'use strict';
  var csrf_token = document.getElementsByName('csrf_token')[0].value;
  $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrf_token;
  $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrf_token;
  $httpProvider.defaults.headers.patch['X-CSRF-Token'] = csrf_token;
});

angular.element(document).ready(function () {
  'use strict';
  angular.bootstrap(document, ['myApp']);
});

angular.module('myApp').run(function () {
  'use strict';
  console.log("Hello from Angular");
});