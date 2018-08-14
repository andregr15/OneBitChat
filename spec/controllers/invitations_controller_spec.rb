require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'

    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  context '#create' do
    before :each do
      @team = create(:team)
      @user = create(:user)
    end

    it 'should receive a return with true' do
      post :create, params: { team_user: {
        team_id: @team.id,
        email: @user.email
      }}
      
      body = JSON.parse(response.body)
      expect(body).to eql(true)
    end

    it 'should receive a return with true' do
      @team.users << @user
      post :create, params: { team_user: {
        team_id: @team.id,
        email: @user.email
      }}

      body = JSON.parse(response.body)
      expect(body).to eql(false)
    end
  end
end