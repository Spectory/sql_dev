#**TDD project docs**

*tdd_tamplate* is a base rails project with testing framework.
you can rename the app by

    ./rename_project NewAppName

coverage reports can be found under *coverage/* folder.
**karma** will generate automatically after every run.
**Rspec** will generate the reports only when you run *COVERAGE=true rspec*.

run *guard* to start auto testing. you might need to edit Guardfile to fit your unique setup.

every time a watched file is saved, tests will run in the background.
**Guard** will trigger rspec, karma, rubucop, jslint (and more. visit Guardfile for full review).

##**Enjoy!**
====

for extra good time, you can read all about the project buildup process:

##**Setup Rspec:**

Rspec is the server testing framework. this is just a summary of rails tutorial chapter 3.

**add gems:**

    group :development, :test do
      gem 'rspec-rails', '~> 3.0.0'
    end
    group :test do
      gem 'selenium-webdriver'
      gem 'capybara'
    end

**terminal:**

    bundle install
    // generate rspec
    rails generate rspec:install
    // create conterollers, for example
    rails generate controller StaticPages home --no-test-framework
    // create tests for controllrers, 
    rails generate integration_test static_pages 

now you can find test files under *spec/requests*

**edit:** 
spec/spec_helper.rb

    RSpec.configure do |config|
      .
      .
      .
      config.include Capybara::DSL
    end

now you can run *rspec* to test your controller.

**sources:**

[http://www.railstutorial.org/](http://www.railstutorial.org/) chapter 3.


##**setup guard:**

guard watches files on your project . when a watched file is saved, rspec is triggered.

**make sure** your RVM version >= 1.11

**add gems:**

    group :development, :test do
     	gem 'guard-rspec'
    end
    group :test do
      # Uncomment this line on OS X.
      # gem 'growl', '1.0.3'
      # Uncomment these lines on Linux.
      # gem 'libnotify'
      # Uncomment these lines on Windows.
      # gem 'rb-notifu', '0.0.4'
      # gem 'wdm', '0.1.0'
    end

**terminal:**

    bundle install
    bundle exec guard init rspec

you can edit the *Guardfile* and specify which files to watch and which tests to run when they are changed.

run *guard* to start watching.

**sources:**

[http://www.railstutorial.org/](http://www.railstutorial.org/) chapter 3.


##**setup sprok**

spork is a testing server. in short, it makes guard work faster.

**gems:**

    group :development, :test do
	  	gem 'spork-rails'
  		gem 'guard-spork'
    end

**terminal**:

    bundle install
    bundle exec spork --bootstrap
    guard init spork

**edit** .rspec file 

    add --drb

now firing *gourd* will also start sprok server.

**sources:**

[https://github.com/guard/guard-spork](https://github.com/guard/guard-spork)

[http://www.railstutorial.org/](http://www.railstutorial.org/) chapter 3.


##**setup jasmine**

jasmine is the client testing framework.

**notice**! if choose not to use karma(we will get there soon) you will probably need to install phantomJS.

**gems:**

    group :development, :test do
		   gem 'jasmine-rails'
    end

**terminal:**

    bundle install
    rails generate jasmine_rails:install

runner file is located at *spec/javascripts/support/jasmine.yml*. make sure paths are correct for your projects hierarchy.

**usage example:**

in order to test *app/assets/javascript/Test.js,* create *spec/javascript/TestSpec.js*


now you can run jasmine by 
    
    RAILS_ENV=test bundle exec rake spec:javascript

**sources:**

[https://github.com/searls/jasmine-rails](https://github.com/searls/jasmine-rails)

##**karama**

karma is the same as guard, it watches files and fire testing when they are changed.

however this feature is troublesome when working in parallel with guard, so we will trigger karma using guard(using guard-shell).

in addition has allot of useful plug in tools. we will use karma-coverage, which will create coverage reports for client side.

**terminal:**

    npm install -g karma --save-dev
    npm install -g karma-cli
    npm install karma-jasmine -g --save-dev
    npm install karma-coverage -g --save-dev

karma can run using any browser like chrome/firefox...
its a good practice to use phantomjs-launcher. it will allow you to lunch karma with phantomjs headless browser.
if you decide to use phantomjs, make sure it is installed on your system.

    npm install karma-phantomjs-launcher --save-dev

you'll need to create config file, follow specs instructions from [http://karma-runner.github.io/0.10/intro/configuration.html](http://karma-runner.github.io/0.10/intro/configuration.html)

    karma init karma.conf.js

make sure that *files[]* include path to all relevent files (including vendor files such as angular).

since we will use guard to trigger karma, make sure to set singleRun: true

you'll need change your config file for coverage specs  [https://github.com/karma-runner/karma-coverage](https://github.com/karma-runner/karma-coverage)	

now you can run karma by:

	karma start karma.conf.js


**sources:**

[https://github.com/karma-runner/karma](https://github.com/karma-runner/karma)

[https://github.com/karma-runner/karma-coverage](https://github.com/karma-runner/karma-coverage)

[http://karma-runner.github.io/0.10/intro/configuration.html](http://karma-runner.github.io/0.10/intro/configuration.html)


##**guard-shell**

guard-shell allows you to trigger terminal command when watched files are changed. so we will set guard to watch client js files, and trigger karma when they are changed.

**gems**

    group :development, :test do
       gem 'guard-shell'
    end

**terminal**

    bundle install
    guard init shell

you will notice an added watcher at guardfile. edit it to something like

    guard :shell do
      watch(/\/javascripts\/(.*)\.js$/) do
        puts `karma start karma.conf.js`
      end
    end

now when any /javascripts/*.js is changed, karma will fire.

**sources:**

[https://github.com/guard/guard-shell](https://github.com/guard/guard-shell)

##**simplecov**

simplecov generate coverage reports for server side.

**gems:**

    group :development, :test do
      gem 'simplecov', :require => false, :group => :test
    end

**terminal**
    
    bundle install

**edit:** add at the top of spec/spec_helper.rb

    require 'simplecov'
    SimpleCov.start 'rails

now running *rspec* will create coverage report under coverage/ folder

**sources:**

[https://github.com/colszowka/simplecov](https://github.com/colszowka/simplecov)

**Great Success!!
"\\(0_0)/"**


##**(Deprecated, we use Specy now.)Jenkins - how to tame the beast**


you must use remote server for Jenkins hosting, trying it on your local machine will conflict with the firewall.

[this tutorial]( http://gistflow.com/posts/492-jenkins-ci-setup-for-rails-application-from-scratch) is the best I managed to find.
bellow you can find what worked for me, no guarantees. good luck.

###*Installation*

find and follow instructions to install Jenkins, nothing special here, normal apt-get...

by default Jenkins listen on port 8080. Jenkins claims you can change the the port by changing startup script args, I had no success with that.
you can use proxy for that too, like Nginx. I failed at that too.

if you used the apt-get installation, Jenkins should be up and start every boot. you can manually control it by
  
    service jenkins status / start / stop

now you should be able to connect to Jenkins (for me it was http://54.77.125.212:8080/).

###*Setup Security*

by defualt jenkins security is down, which means anyone can fiddle around our Jenkins. we want it to have an admin user, which will be able give other users permissions.

1. **go to** Jenkins -> Configure Global Security
2. **check** 'Enable security', 'Jenkins’ own user database', 'Allow users to sign up', 'Matrix-based security'.
3. under **User/group to add:** give your admin user a name and, click add and check all permission boxes.
4. you should have an Anonymous user with read permissions (under overall & jobs).
4. **save**. now security is up. if you go back to Jenkins home screen. you should be able to signup/login.
5. signup with the same name as your admin user.
6. now you are logged in as admin. you can turn off 'Allow users to sign up' to block any other users access.


###*Setup server*

once Jenkins is installed on your machine, it has a unix user. you'll need to make him sudo, do that before proceeding.

switch to jenkins user by one of the commands
  
    sudo su jenkins //stay at current dir
    sudo su - jenkins //move to jenkins home folder

install all dependencies you used at your rails project (git, rvm, ruby, jasmine, phantomJS...).

if everything is ok, you should now be able run your tests on server and see them pass/fail on console.
  
    bundle install
    rspec
    RAILS_ENV=test bundle exec rake spec:javascript


###*Connect with bigbucket*

first we need to add the some plugins.

1. Jenkins -> manage Jenkins -> plugin manager
2. under 'avalible', search and install "GIT plugin", "Rvm", "TextFinder plugin". 

you also need to create a git user for jenkins, the email and name doesn't really matter just use

    sudo git config –global user.email “example@email.com”
    sudo git config –global user.name “jenkins”

and we need to create Jenkins ssh keys.

    sudo su jenkins
    ssh-keygen // don't type anything, leave fields black.

this will create a public-private pair under ~/etc/.ssh.

this is a good time to restart jenkins, some plugins will take affect only after reboot.

---

now we need to create a Jenkins 'Item' (most docs refer it as 'Job'), which will have read-only permission on our git repository.

1. **go to** Jenkins -> new Item.
2. give your item a name and **check** 'Build a free-style software project'
3. under 'Source Code Management', choose Git.
4. under 'Repository URL', place your bigbucket repository address (in SSH format).
5. under 'Credentials', click add.
6. set 'SSH with private key', choose a name, set scope 'global' , private key 'From the Jenkins master ~/.ssh' and click add.
7. under 'Credentials', choose your created credential.

go to your bigbucket repository -> settings -> deployment keys -> add key.
you'll need to paste the content of ~/.ssh/id_rsa.pub there.

now when a push accrues, Jenkins will be informed, but we need to tell him what to do. we want bigbucket to ask Jenkins to run a *build*. this is done using a *hook*

1. go to Jenkins -> people 
2. choose the admin user and go to configure.
3. click 'show API token' and copy it.
4. go to bigbucket, choose your repository and go to settings.
5. under 'Hooks', add a Jenkins hook.
6. set endpoint with the foramt  http://{user}:{API-token}@jenkinsURL. 
    for me the result was http://admin:9*****3@54.77.125.212:8080
7. leave 'module name' empty.
8. set 'project name' with your Item name.
9. 'token' is the message that bigbucket will send Jenkins when a push accrues. it can be any non-empty random string.
10. go back to your jenkins item. jenkins->views->item name ->configure.
11. under 'Build Triggers' select 'Trigger builds remotely' and set 'Authentication Token' with the random string from step 9 

we have a secured notification form bigbucket to Jenkins when push accrues. 
you can go to your Jenkins item and click 'build now' to see if things work as expected. after build is finished you should see a copy of the git repository under item -> workspace, and build should be successful.

---

now we need to define a build action.
 
 goto item->configure->Build-> add build step->execute shell.

 write your script building the project, and running tests. something like 

    #!/bin/bash -x
    bundle install
    rspec 
    RAILS_ENV=test bundle exec rake spec:javascript

when build accures, the output can be seen at build#->console.

Jenkins indicates when a build was successful or not, it does not inform when test are failing. for that you should check the console output for failures. I used TextFinder plugin for that.


1. goto item->configure->Post-build Actions->Jenkins text finder.
2. **check** 'Also search the console output', 'unstable if found'
3. set 'Regular expression' with your desired java regex pattern. for example *[1-9]\d* failure*


ARRRRGGGGG!!!