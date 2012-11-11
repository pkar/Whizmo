Hack City - InSite
==================

Providing actionable insight into building performance

Submit to http://sanfrancisco.cleanweb.co/ San Francisco Hackathon at Verge
http://whizmo.herokuapp.com/

Building Energy
Utilizing the JCI Panoptix API's - http://whatspossible.johnsoncontrols.com/community/panoptix


Team
----
Doug Mackay - Energy SME

Paul Karadimas - Hello

Callie Bailey - Architect/Designer

Chris Faulkner - Developer

Yoann Assayag - Energy and software student

Fernando Siu - Analytics/Real Estate Investor


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
