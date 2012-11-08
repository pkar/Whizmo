Whizmo
======
Hello, Cleanweb

Quick Run Local
---------------
Assuming meteor is installed just run 

    meteor 
    # goto http://localhost:3000

    http://whizmo.herokuapp.com/


# Requires mongohq, make sure account is verified by adding CC 

    # heroku addons:add mongohq:free
    # heroku addons:add mailgun:starter

    heroku create whizmo --stack cedar --buildpack https://github.com/pkar/heroku-buildpack-meteor.git
    #heroku config:set ROOT_URL=http://whizmo.herokuapp.com
    #heroku config:set FILEPICKERIO=ApH1oY5HHQy_____
    #heroku config:set GOOGLE_ANALYTICS=key
    # Locally FILEPICKERIO env must be set 
    export FILEPICKERIO=apikey
    export GOOGLE_ANALYTICS=apikey

    # To deploy just commit and push
    # git commit -m "commit details"
    # git push heroku master


# Caveats
1.  Since a canonical layout is unknown, try using this layout structure

    ## https://github.com/tmeasday/unofficial-meteor-faq#where-should-i-put-my-files
    ## Listed here for reference only

    lib/                    # <- any common code for client/server. 
    lib/environment.js      # <- general configuration
    lib/methods.js          # <- Meteor.method definitions
    lib/external            # <- common code from someone else
    ## Note that js files in lib folders are loaded before other js files.

    collections/                 # <- definitions of collections and methods on them (could be models/)

    client/lib              # <- client specific libraries (also loaded first)
    client/lib/environment.js   # <- configuration of any client side packages
    client/lib/helpers      # <- any helpers (handlebars or otherwise) that are used often in view files

    client/application.js   # <- subscriptions, basic Meteor.startup code.
    client/index.html       # <- toplevel html
    client/index.js         # <- and its JS
    client/views/<page>.html  # <- the templates specific to a single page
    client/views/<page>.js    # <- and the JS to hook it up
    client/views/<type>/    # <- if you find you have a lot of views of the same object type

    server/publications.js  # <- Meteor.publish definitions
    server/lib/environment.js   # <- configuration of server side packages

    Files in [project_root]/lib are loaded first. Obviously, put libraries in this directory.
    Files are sorted by directory depth. Deeper files are loaded first.
    Files are sorted in alphabetical order.
    main.* files are loaded last. These are nice for code that needs to be run after every other script and library has loaded.
    Meteor has some special directories that help you deal with breaking apart client/server code and deal with load order:

    [project_root]/lib/ - Files in this directory will get loaded before your client/server code starts.
    [project_root]/client/ - Files here are only sent to the client’s browser and aren’t available or run from the server.
    [project_root]/server/ - Files here are only run on the server and aren’t available on the client.
    [project_root]/public/ - Meteor serves static media from this directory. If you put image.jpg in here, feel free to refer to it directly as image.jpg in your html.
    [project_root]/.meteor/ - Meteor keeps special, project related info in here, like which modules you’ve installed. You really shouldn’t need to poke around in here.
      


2. File storage is handled by filepicker.io going to an S3 bucket

  1. Open an AWS account and setup a bucket in S3
    - Under Properties, click Add bucket policy, make sure name is only lowercase

    {
      "Version": "2008-10-17",
      "Statement": [
        {
          "Sid": "Stmt13503376278__",
          "Effect": "Allow",
          "Principal": {
            "AWS": "*"
          },
          "Action": [
            "s3:DeleteObject",
            "s3:GetObject",
            "s3:PutObject"
          ],
          "Resource": "arn:aws:s3:::whizmo.filepickerio/*"
        }
      ]
    }

  2. In filepicker.io settings add AWS Access Key ID, Secret Access Key
  and bucket name of whizmo.filepickerio
    - Also set the App arl to your domain

