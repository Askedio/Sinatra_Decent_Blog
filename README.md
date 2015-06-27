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

```
echo -n .. > ~/.env/user_vars/CLOUDINARY_CLOUD_NAME
echo -n .. > ~/.env/user_vars/CLOUDINARY_KEY
echo -n .. > ~/.env/user_vars/CLOUDINARY_SECRET
echo -n .. > ~/.env/user_vars/MAILGUN_APIKEY
echo -n .. > ~/.env/user_vars/MAILGUN_DOMAIN
```

License
----------------------------
The MIT License (MIT)

Copyright (c) 2015 William Bowman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.