daycare-decisions
=================

Pilot version to fulfill milestone 1.  To be used to refine data models and collect information about what's needed.

Local Demos
-----------

The local version can be used to demo all the UI services including the AngularJS front end.  To do this:

1.  clone repo daycare-decisions from github or heroku.
2.  cd into daycare-decisions
3.  Create the database locally using the csv:load_providers rake command (optional)
4.  Configure the local environment:

    - bundle exec rake db:drop && db:create && db:migrate && db:seed && csv:load_providers

5.  Start the rails server

    - $ rails s
    
6.  Start the python (bottle.py) server

    - $ cd frontend/_server
    - $ python devserver.py

7.  Start a browser on localhost:3000
8.  Start a browser on localhost:8082

Remote Demos
------------

Set the URL to:

   http://daycaredecisionsmaster464c.ninefold-apps.com/

Note:  Remote demos will probably run at root, root/home and root/api.  root:8082 is not implemented.
Root displays the frontend UI but it does not handle keystroke events.  root/home will display the original (Rails) UI and searches execute correctly.  root/api displays the API Guide and the API requests work properly.

Warning:  Invoked from Heroku the views do not render properly and API calls do not work.  This is a configuration problem.  Demos should be run from Ninefold.
