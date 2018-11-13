class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.share.subject
  #
  def share(email, trip, path)
    @email = email
    @trip = trip
    @path = path
    #@url = "http://www.flyingpengu.com/@path"
    mail(to: @email , subject: 'Travel details shared')
  end
end
