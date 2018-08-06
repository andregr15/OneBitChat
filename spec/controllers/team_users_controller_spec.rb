require 'rails_helper'

RSpec.describe TeamUsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before :each do 
    request.env['HTTP_ACCEPT'] = 'application/json'

    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  describe 'POST #create' do
    context 'User is the team owner' do
      before :each do
        @team = create(:team, user: @current_user)
        @guest_user = create(:user)
      end

      it 'should returns http success' do
        post :create, params: { team_user: { user_id: @guest_user.id, team_id: @team.id } }
        expect(response).to have_http_status(:success)
      end
    end

    context 'User is not the team owner' do
      before :each do
        @team = create(:team)
        @guest_user = create(:user)
      end

      it 'should returns http forbidden' do
        post :create, params: { team_user: { user_id: @guest_user.id, team_id: @team_id } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'User is the team owner' do
      before :each do
        @team = create(:team, user: @current_user)
        @guest_user = create(:user)
        @team.users << @guest_user
      end

      it 'should returns http success' do
        delete :destroy, params: { user_id: @guest_user.id, team_id: @team.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'User is not the team owner' do
      before :each do
        @team = create(:team)
        @guest_user = create(:user)
        @team.users << @guest_user
      end

      it 'should returns http forbidden' do
        delete :destroy, params: { user_id: @guest_user.id, team_id: @team.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

end