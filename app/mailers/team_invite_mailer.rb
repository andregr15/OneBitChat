class TeamInviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_invite_mailer.invitation.subject
  #
  def invitation(invite)
    @invite = invite
    mail to: @invite.email, subject: "Invitation to team #{ @invite.team.slug }"
  end
end
