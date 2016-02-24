/*globals angular, document, JST, window */

angular.module('app.services', []);
angular.module('app.directives', []);
angular.module('app.filters', []);
angular.module('app.controllers', []);

angular.module('app', ['app.services', 'app.directives', 'app.filters', 'app.controllers'], ['$httpProvider',
  function ($httpProvider) {
    'use strict';

    var csrf_token = document.getElementsByName('csrf-token')[0].content;
    $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrf_token;
    $httpProvider.defaults.headers.put['X-CSRF-Token'] = csrf_token;
    $httpProvider.defaults.headers.patch['X-CSRF-Token'] = csrf_token;
  }]);

angular.element(document).ready(function () {
  'use strict';
  angular.bootstrap(document, ['app']);
});


angular.module('app').run(function () {
  'use strict';
});
