WORK TIMELINE
=============
FRI - Get spec written as well as initial research
			Create the (empty) app, start a GitHub repository and create the database and models
SAT - Get basic controllers and views in place including all page links
SUN - As above
MON - Get testing in place and test
TUE - 
WED - Initial deployment
			Styling - use SASS?
THU - Extension(s)
FRI - Documentation tidy up
			Code tidy up
			Final deployment

QUESTIONS - GENERAL
===================
What sort of payment model to implement?

WDI PROJECT THREE - 99CENTS
===========================

OVERVIEW
========

A grass roots auction app to encourage people to list auctions at 99 cents. It will be aimed at those peole who just want to sell theiR goods that they no longer need and allow buyers to pick up a bargain. The can list a minimum bid or buy it now price if preferred but this will incur costs. A sale fee will apply if the auction item sells

MODELS
======

### The following object models will be used to construct this app:
Note all prices will be in cents and specified as integers

USER
----
First name
Last name
Email address
Username
Password

A user can have zero, one or many auctions
A user can have zero, one or many bids

AUCTION
-------
Category
Number
Title
Item condition
Item description
Start price
Current bid
Start time
End time
Buy it now price
Reserve
Pictures - up to 10
Status: pending, listed (live), closed
User ID: foreign key

An auction belongs to a user
An auction can have zero, one or many bids

BID
===
Amount
Bid time
User ID
Auction ID

A bid belongs to a user
A bid belongs to an auction

STANDARD FEATURES
=================

### A user will be able to perform the following actions:

* Browse to the home page and About page without having to log in
* Browse all users' auctions without logging in
* Be able to create an account
* Be able to see and edit their account details
* Be able to close their account
* Be able to login/logout and only have full access to the site when logged in
* Create a new auction
* Show an auction's details
* Edit their own auctions' details but only up until 24 hours until the end
* See all their auctions
* Delete an auction if it is not yet listed or request an auction be deleted if it is already listed
* Show other users' cars but not be able to create, edit or delete them - relevant links should be removed
* Add pictures to the cars they have created

EXTENSIONS
==========
* Add confirmable and lockable (Devise functionality)
* Think of ways of making the site dynamic, e.g. have a popup for bidding instead of a separate page
* Searching, especially by category
* Additional pictures and the ability to dynamically view them in a (popup?) window
* Admin account for user request management
* Email notification for such things as when they win/sell an item, when listings are about to close, when they get outbid, etc.
* Auction watch list
* Make the app responsive (mobile first)
* Feedback (name it something else - perhaps Reputation)
* Payment facility for users and bidders
* Payment setup for ended auctions
* Questions and answers about the auction
* Postage and payment options
* Schedule a listing start time for an auction
* Have a username choice system to ensure that each username is unique
* Add other login authentication options (Facebook, etc.)

RESOURCES
=========

### The following resources are associated with this project:

Devise for user login: https://rubygems.org/gems/devise
Examples to draw inspiration from:
		https://github.com/netmarkjp/rails-auction
		https://github.com/stevenwanderski/auction
Pundit for authorisation: https://github.com/elabs/pundit









===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================