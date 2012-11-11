InSite
======

Submit to http://sanfrancisco.cleanweb.co/ San Francisco Hackathon at Verge

http://whizmo.herokuapp.com/


Requirments
-----------


Quick Run Local
---------------
Install Meteor

    curl https://install.meteor.com | /bin/sh

Pull repo and run meteor, all packages should load automatically.

    git pull https://github.com/pkar/Whizmo.git
    meteor 

Goto http://localhost:3000

Deployed on Heroku
------------------

If initial stack creation

    heroku create --stack insite --buildpack https://github.com/jordansissel/heroku-buildpack-meteor.git
    heroku addons:add mongohq:sandbox

If adding already created repo

    heroku git:remote -a whizmo
    git push heroku master
