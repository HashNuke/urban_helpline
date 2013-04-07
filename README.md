# Urban Helpline

Application to setup and manage a helpline for information on non-emergency services. It uses cloud-telephony to make the setup a breeze.

This is an app for the [12th plan hackathon](http://data.gov.in/hackathon/).
It focuses on the Urban Development section of the 12th five-year plan plan.

## Requirements

The app needs to be hosted online to use

## Installation and requirements

* Install Ruby 2.0, rubygems, bundler and rake using RVM or rbenv.

* Install MongoDB

* Copy paste the following commands:

    git clone git://github.com/HashNuke/urban_helpline.git
    cd urban_helpline
    bundle install

* To create a sample user run:

    bundle exec rake install

## Deployment and starting the server in development

* On local machine

    bundle exec thin start

* For production env, edit `config/mongoid.yml` and set mongodb config. Also edit config/settings.yml if necessary to set your cloud telephony provider.

* For deploying on Heroku, you don't need to change anything. Just create a heroku app and push this repo. Then add the mongohq sandbox db addon.

    heroku addons:add mongohq:sandbox


## How to use other cloud telephony providers?

For an example look up `lib/telephone_providers/exotel.rb`. If your provider is called "Sample", create a class called "SampleProvider" and implement the class method `handle_call_data_webhook`. All params that are in the http request will be passed to it. So it's upto you to pickup what you want.

Set the webhook url `<your-app-domain>/data/calls` in your cloud telephony provider's settings.
