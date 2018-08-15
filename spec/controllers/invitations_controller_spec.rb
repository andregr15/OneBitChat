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
      @email = FFaker::Internet.email
    end

    it 'should receive a return with true' do
      post :create, params: { team_user: {
        team_id: @team.id,
        email: @email
      }}
      
      body = JSON.parse(response.body)
      expect(body).to eql(true)
    end

    it 'should receive a return with false' do
      @team.users << @user
      post :create, params: { team_user: {
        team_id: @team.id,
        email: @user.email
      }}

      body = JSON.parse(response.body)
      expect(body).to eql(false)
    end

    context 'should have create the invite in the database' do
      before do
        post :create, params: { team_user: {
          team_id: @team.id,
          email: @email
        }}
      end

      it 'should have created the invite in the database with the correct e-mail' do
        expect(Invite.first.email).to eql(@email)
      end

      it 'should have created the invite in the database with the correct team' do
        expect(Invite.first.team.id).to eql(@team.id)
      end

      it 'should have created the invite in the database with a token' do
        expect(Invite.first.token).not_to be_nil
      end

      it 'should have created the invite in the database with visualized equals false' do
        expect(Invite.first.visualized).to be false
      end

      it 'should have created the invite in the database with accepted equals false' do
        expect(Invite.first.accepted).to be false
      end
    end
  end
end