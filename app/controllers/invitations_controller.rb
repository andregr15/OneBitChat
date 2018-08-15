class InvitationsController < ApplicationController
  before_action :set_invitation_params, only: [:create]

  def create
    invite = Invite.find_by(email: @email)
    if !@team || @user && @team.users.where(id: @user.id).present? || invite
      respond_to do |format|
        format.json { render json: false }
      end
    else
      invite = Invite.create(email: @email, team: @team)
      SendMailJob.new(invite).perform
      respond_to do |format|
        format.json { render json: true }
      end
    end
  end

  private

  def set_invitation_params
    params.require(:team_user).permit(:team_id, :email)

    @user = User.find_by(email: params[:team_user][:email])
    @email = params[:team_user][:email]
    @team = Team.find(params[:team_user][:team_id])
  end
end