class TeamsController < ApplicationController
  before_action :set_team, only: [:destroy]
  before_action :set_by_slug_team, only: [:show]

  def index
    check_token
  end

  def show
    authorize! :read, @team
  end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to "/#{@team.slug}" }
      else
        format.html { redirect_to main_app.root_url, notice: @team.errors }
      end
    end
  end

  def destroy
    authorize! :destroy, @team
    @team.destroy
    
    respond_to do |format|
      format.json { render json: true }
    end
  end

  private

  def set_by_slug_team
    @team = Team.find_by(slug: params[:slug])
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:slug).merge(user: current_user)
  end
  
  # method to check if the token exists and if de current_user is the owner of the invite
  def check_token
    if cookies[:token]
      invite = Invite.find_by(token: cookies[:token])
      if invite.email == current_user.email
        redirect_to "/invitations/#{cookies[:token]}"
      end
      
      cookies.delete(:token)
    end
  end
end
