WORK TIMELINE
=============
FRI - Get spec written as well as initial research
			Create the (empty) app, start a GitHub repository and create the database and models
SAT - Get basic controllers and views in place including all page links
SUN - Get basic auction creation and bid functionality working
MON - Build in all remaining fundamental features and checks
TUE - Scheduling
WED - Initial deployment
			Styling - use SASS?
THU - Extension(s)
FRI - Get testing in place and test
			Documentation tidy up
			Code tidy up
			Final deployment

TO DO
=====
Refine and add to the About page
Clean up any puts statements in controllers, etc
Before deploying remove the hard coded scheduler for auction end time (duration)
Refactor large blocks of code in controllers - add to models
Update links in emails to point to the relevant Heroku links
Research "Modal" - a popup form creator
Research Foundation for styling
Update model information

TO ASK ABOUT
------------
Is storing information in the session a bad idea? What are some other ways? See the way it has been done in the questions and answers. Also need to know how to redirect to different places, e.g. login redirection for new auction when logged out
How to move model logic out of controllers?

WDI PROJECT THREE - 99CENTS
===========================

OVERVIEW
========

A grass roots auction app to encourage people to list auctions at 99 cents. It will be aimed at those peole who just want to sell their goods that they no longer need and allow buyers to pick up a bargain. The can list a minimum bid or buy it now price if preferred but this will incur costs. A sale fee will apply if the auction item sells

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
* Bid on an auction but not their own
* See all their auctions
* Delete an auction if it is not yet listed or request an auction be deleted if it is already listed

USE JAVASCRIPT FOR
------------------
Countdown within 24 hours of auction ending
Bidding
Auction just ended
Picture popup to scroll through them
Limit days of the month for those months with 30 days or less (new auction page)

CHECKLIST
=========

Check photo uploading (cloudinary)

DONE Allow the user to enter prices with or without cents
DONE Add final status of the auction:
* Email notifications for the following scenarios:
	>>>>>>>>>>> Get working and add contents for email views
DONE Auctions belonging to a user - place in My Account
DONE Prevent an auction from being deleted once it is live
DONE Auction watch list - add/remove when a user clicks on a "Watch Now" link or places a bid
DONE Implement a scheduler for auction state changes, emails, auction start times, etc.
DONE Schedule auction start times
DONE Handle the case where a second user enters the same high bid as the winning bidder
DONE Prevent bidding on one's own auctions
DONE Advise on an auction whether a bidder is winning or outbid and who holds the auction so far
DONE Enable high bidders to increase their bid (without increasing the current bid)
DONE Show bidder's high bid on the auction if they are winning
DONE Add bidding history
DONE Questions and answers about the auction
DONE Show whether or not the reserve has been met

Research "Modal" - a popup form creator
Research Foundation for styling

EXTENSIONS
==========

* Add a generic "no picture" picture if one is not provided on the new auction page
* Add seller information to each auction
* Handle all time zones
* Add Buy It Now to the auction view and new pages
* List auctions by category
* Searching, especially by category
* Additional pictures
* Allow the runner up bidder to enter another bid for a short time after the auction ends
* Add Devise authentication (also add confirmable and lockable)
* Admin account for user management
* Make the app responsive (mobile first)
* Add a Feedback feature (name it something else - perhaps Reputation)
* Payment facility for users and bidders
* Payment setup for ended auctions
* Postage and payment options
* Increase the increment according to the value of the item

RESOURCES
=========

### The following resources are associated with this project:

Devise for user login: https://rubygems.org/gems/devise
Example auction site projects to draw inspiration from:
		https://github.com/netmarkjp/rails-auction
		https://github.com/stevenwanderski/auction
    https://github.com/eugmill/freebay-auction-app-ruby-004
Pundit for authorisation: https://github.com/elabs/pundit
Email notifications: https://howilearnedrails.wordpress.com/2014/02/25/setting-up-email-in-a-rails-4-app-with-action-mailer-in-development-and-sendgrid-in-production-using-heroku/
Search functionality: https://github.com/lyntco/bookbase/blob/master/app/controllers/pages_controller.rb
Scheduler: https://github.com/jmettraux/rufus-scheduler
Rails email info: http://guides.rubyonrails.org/action_mailer_basics.html
Email server for SMTP mail: https://sendgrid.com/docs/User_Guide/index.html
Time zone manipulation: http://thisbythem.com/blog/clientside-timezone-detection/
Scrolling photo banner: http://designshack.net/articles/css/infinitephotobanner/
Buttons:
    http://cssdeck.com/labs/fancy-3d-button
		http://www.sanwebe.com/2013/01/40-css-buttons-from-codepen
Other effects:
		http://www.css3.info/preview/box-shadow/
