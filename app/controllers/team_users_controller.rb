class TeamUsersController < ApplicationController
  before_action :set_team_user, only: [:destroy, :show]

  def show
    respond_to do |format|
      if @team_user
        format.json { render json: true }
      else
        format.json { render json: false }
      end
    end
  end

  def create
    @team_user = TeamUser.new(team_user_params)
    authorize! :create, @team_user

    respond_to do |format|
      if @team_user.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @team_user
    @team_user.destroy

    respond_to do |format|
      format.json { render json: true}
    end
  end

  private

  def set_team_user
    @team_user = TeamUser.find_by(user_id: params[:id], team_id: params[:team_id])
    if !@team_user
      @team = Team.find(params[:team_id])
      if @team.user.id == params[:id].to_i
        @team_user = @team.user.id
      end
    end
  end

  def team_user_params
    user = User.find_by(email: params[:team_user][:email])
    params.require(:team_user).permit(:team_id).merge(user_id: user.id)
  end
end