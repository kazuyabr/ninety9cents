class UserMailer < ActionMailer::Base
  default from: "mike13726548@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to ninety9cents!')
  end

  def close_account_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Sorry to see you go...')
  end

  def password_change_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Password change')
  end

  def failed_login_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Failed login attempt')
  end

  def auction_won_email(user, auction)
    @user = user
    @auction = auction
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "You won auction #{@auction.title}")
  end

  def auction_lost_email(user, auction)
    @user = user
    @auction = auction
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Sorry you did not win auction #{@auction.title}")
  end

  def auction_ending_email(user, auction)
    @user = user
    @auction = auction
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Auction #{@auction.title} is ending soon!")
  end

  def auction_ended_email(user, auction)
    @user = user
    @auction = auction
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'watched auction #{@auction.title} has ended')
  end

 	def my_auction_ended_email(user, auction)
    @user = user
    @auction = auction
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Auction #{@auction.title} that you have listed has ended')
  end

end
