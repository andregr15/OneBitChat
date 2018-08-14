class InvitationsController < ApplicationController
  before_action :set_invitation_params, only: [:create]

  def create
    if !@user || !@team || @team.users.where(id: @user.id).present?
      respond_to do |format|
        format.json { render json: false }
      end
    else
      SendMailJob.new(@team, @user).perform
      respond_to do |format|
        format.json { render json: true }
      end
    end
  end

  private

  def set_invitation_params
    @user = User.find_by(email: params[:team_user][:email])
    @team = Team.find(params[:team_user][:team_id])
  end
end