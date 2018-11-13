# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/share
  def share(user, trip, path)
    @user = user
    @trip = trip
    @path = path
    #@url = "http://www.flyingpengu.com/@path"
    mail(to: @user.email , subject: 'Travel details shared')
  end

end
