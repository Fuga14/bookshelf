class UserMailer < ApplicationMailer
  def import_report(user, import)
    @user = user
    @import = import
    
    mail(
      to: @user.email,
      subject: "Import Books Report - #{@import.status.humanize}"
    )
  end
end

