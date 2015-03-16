# ![Dolphin Logo](https://github.com/bboe/dolphin/blob/14e347c6ee3182d898ddd69247adfec6e110d204/app/assets/images/dolphin.png) Dolphin

Dolphin is a webservice designed to promote discussion about better security
practices. At its core Dolphin provides a fun game-like environment that
encourages people to lock their computers complete with lists of "Recent
Dolphins", "Top Dolphinees", and "Top Dolphineers".

Dolphin relies on Google OAuth to verify accounts. Under non-public
deployments, it is intended to be configured to only authorize accounts from
the specific Google Apps domain.

A public demo version of Dolphin can be found at:
https://dolphin-demo.herokuapp.com/

## Heroku Deployment

Dolphin is a rails application that can be deployed anywhere. However,
out-of-the-box it will run on the free tier or Heroku. Below are the steps to
configure and deploy the application assuming you already have a heroku account
set up, and the repository cloned.

* From your local clone of the repository create a heroku app

        heroku create [app-name]

* Configure and obtain the necessary Google API credentials

  * http://richonrails.com/articles/google-authentication-in-ruby-on-rails

  * Add `https://APPNAME.herokuapp.com/users/auth/google_oauth2/callback` to
    the list of __Authorized Redirect URIs__

* Configure the heroku envioronment

        heroku config:set GOOGLE_CLIENT_ID=YOUR_GOOGLE_CLIENT_ID
        heroku config:set GOOGLE_CLIENT_SECRET=YOUR_GOOGLE_CLIENT_SECRET
        # If you intend on restricting access to a Google Apps Domain
        heroku config:set GOOGLE_CLIENT_DOMAIN=YOUR_GOOGLE_APP_DOMAIN
        # If you want the App's title to be something other than Dolphin
        heroku config:set APP_TITLE=YOUR_APP_TITLE

* Deploy to heroku

        git push heroku master

* Migrate the database

        heroku run rake db:migrate

## Copyright and license

Source released under the Simplified BSD License.

* Copyright (c), 2015, AppFolio, Inc
* Copyright (c), 2015, Bryce Boe

---

Dolphin logo Copyright (c), 2014 Google  
Licensed under the Apache License, Version 2.0  
http://commons.wikimedia.org/wiki/File:Emoji_u1f42c.svg