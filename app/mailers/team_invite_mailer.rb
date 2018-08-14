class TeamInviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_invite_mailer.invitation.subject
  #
  def invitation(team, user)
    @team = team
    @user = user
    mail to: @user.email, subject: "Invitation to team #{ @team.slug }"
  end
end
