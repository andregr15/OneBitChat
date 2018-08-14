# Preview all emails at http://localhost:3000/rails/mailers/team_invite
class TeamInvitePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/team_invite/invitation
  def invitation
    TeamInviteMailer.invitation
  end

end
