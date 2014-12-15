WORK TIMELINE
=============
FRI - Get spec written as well as initial research
			Create the (empty) app, start a GitHub repository and create the database and models
SAT - Get basic controllers and views in place including all page links
SUN - Get basic auction creation and bid functionality working
MON - Build in all remaining findamental features and checks
TUE - 
WED - Initial deployment
			Styling - use SASS?
THU - Extension(s)
FRI - Get testing in place and test
			Documentation tidy up
			Code tidy up
			Final deployment

TO DO
=====
Get the params require working in the auctions controller
Refine and add to the About page
Change the auction Duration table column to Integer, then refactor the way that the end time is calculated

TO ASK ABOUT
------------
Problem with validation errors also showing the array as well as the relevant errors
Is storing information in the session a bad idea? What are some other ways?
Can databases always be relied upon to return data in order?

QUESTIONS - GENERAL
===================
What sort of payment model to implement?

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
Countdown within 24 hours of auctioin ending
Bidding
Auction just ended

EXTENSIONS
==========

DONE Handle the case where a second user enters the same high bid as the winning bidder
DONE Prevent bidding on one's own auctions
* Advise on an auction whether a bidder is winning or outbid and who holds the auction so far
DONE Enable high bidders to increase their bid (without increasing the current bid)
* Show bidder's high bid on the auction if they are winning
* Add ability to schedule auction start times
* Add bidding history
* Questions and answers about the auction
* Schedule a listing start time for an auction
* Show whether or not the reserve has been met
* Add Devise authentication (also add confirmable and lockable)
* Add admin functionality
* Think of ways of making the site dynamic, e.g. have a popup for bidding instead of a separate page
* List auctions by category
* Searching, especially by category
* Additional pictures and the ability to dynamically view them in a (popup?) window
* Admin account for user request management
* Email notification for such things as when they win/sell an item, when listings are about to close, when they get outbid, etc.
* Auction watch list
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
Examples to draw inspiration from:
		https://github.com/netmarkjp/rails-auction
		https://github.com/stevenwanderski/auction
    https://github.com/eugmill/freebay-auction-app-ruby-004
Pundit for authorisation: https://github.com/elabs/pundit
Email notifications: https://howilearnedrails.wordpress.com/2014/02/25/setting-up-email-in-a-rails-4-app-with-action-mailer-in-development-and-sendgrid-in-production-using-heroku/
