class SendMailJob < ApplicationJob
  queue_as :default

  def initialize(team, user)
    @team = team
    @user = user
  end

  def perform
    TeamInviteMailer.invitation(@team, @user).deliver_later
  end
end