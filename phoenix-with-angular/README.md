# PhoenixTemplate

###pre-requirement:
 - npm version > 3

###Added packages & configurations:

 - [ESpecPhoenix](https://github.com/antonmi/espec_phoenix) - testing framework.
 - [excoveralls](https://github.com/parroty/excoveralls) - cli coverage reports.
 - [Apex](https://github.com/bjro/apex) - awesome print.
 - angular
 - karma

###Files Structure:
 - web/static/vendor - vendor files & external libs such as angular, lodash, Ramda...
 - web/static/js/* - your src code + phoenix socket.js & app.js
 - spec/js - your spec files
 - spec/support - general helpers & vendor modules that are relevant only for tests. Things like spec_helpers, angular-mocks...

###Adding src files 
 - Add src files under web/static
 - Update app.js imports. This is very similar to Rails's application.js. You don't need to include vendor files at app.js.
 - Update karma.conf

###completion process
 - Files are compiled according to branch-config defaults. All js files are compiled into app.js at the order:
    - web/static/vendor
    - web/static/js

If you wish to refine the compilation order, edit branch-config.js.

###Running stuff:
```Elixir
# running the app
  mix phoenix.server
# running the app with interactive console.
  iex -S mix phoenix.server #runs the app.
# running Espec
  mix espec
# running Espec with coverage 
  mix espec --cover
# running karma
  karma start
```

###Readings
 - [Phoenix Guide](http://www.phoenixframework.org/docs/overview)
 - [Elixir Guide](http://elixir-lang.org/getting-started/introduction.html)
 - [awesome-elixir](https://github.com/h4cc/awesome-elixir)

###TODO:
 - a scripts that renames the app from PhoenixTemplate to a given app name.
 - setup for heroku deployment.