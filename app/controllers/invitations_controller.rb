class InvitationsController < ApplicationController
  before_action :set_invitation_params, only: [:create]
  before_action :set_invite, only: [:show, :update]
  before_action :authenticate_user!, except: [:show]

  def show
    if !current_user && @invite.accepted == false
      # setting the token in a cookie
      cookies[:token] = {
        value: params[:id]
      }
    end
  end

  def update
    # updating the invite
    @invite.visualized = true
    @invite.accepted = true

    respond_to do |format|
      if @invite.save
        # adding the user to the team
        TeamUser.create(user_id: current_user.id, team_id:@invite.team.id)
        # redirecting the user to the team
        format.html { redirect_to "/#{@invite.team.slug}"}
      else
        format.html { redirect_to main_app.root_url, notice: @invite.errors }
      end
    end

  end

  def create
    # finding the invite and destroing it in case of resending
    invite = Invite.find_by(email: @email)
    invite.destroy
    # checking if the user already is a team member
    if !@team || @user && @team.users.where(id: @user.id).present?
      respond_to do |format|
        format.json { render json: false }
      end
    else
      # creating the invite and calling the SendMailJob
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

  def set_invite
    @invite = Invite.find_by(token: params[:id])
  end
end