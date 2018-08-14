class SendMailJob < ApplicationJob
  queue_as :default

  def perform(team, user)
    TeamInviteMailer.invite(team, user).deliver_later
  end
end