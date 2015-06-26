Sinatra Decent (Simple) Blog
====================

As seen at https://asked.io/tag/sinatra-decent-blog

What is this project?
----------------------------

A really simple (decent) Sinatra Blog Hosted on OpenShift https://www.openshift.com

Setup
----------------------------
* Git clone
* bundle install
* rackup


Extended Setup
----------------------------
To enable mailgun and openshift define local environment variables, if you're on openshift do what you see below, replace .. with the setting.

echo -n .. > ~/.env/user_vars/CLOUDINARY_CLOUD_NAME

echo -n .. > ~/.env/user_vars/CLOUDINARY_KEY

echo -n .. > ~/.env/user_vars/CLOUDINARY_SECRET

echo -n .. > ~/.env/user_vars/MAILGUN_APIKEY

echo -n .. > ~/.env/user_vars/MAILGUN_DOMAIN

