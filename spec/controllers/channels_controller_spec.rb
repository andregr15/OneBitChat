require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'

    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  describe 'POST #create' do
    # adding json rendering for the tests
    render_views

    context 'User is team member' do
      before :each do
        @team = create(:team)
        @team.users << @current_user
        
        @channel_attributes = attributes_for(:channel, team: @team, user: @current_user)
        post :create, params: { channel: @channel_attributes.merge(team_id: @team.id) }
      end

      it 'should returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'should create the channel with the right params' do
        expect(Channel.last.slug).to eql(@channel_attributes[:slug])
        expect(Channel.last.user).to eql(@current_user)
        exepct(Channel.last.team).to eql(@team)
      end

      it 'should return the right values of the created channel' do
        response_hash = JSON.parse(response.body)

        expect(response_hash['user_id']).to eql(@current_user.id)
        expect(response_hash['slug']).to eql(@channel_attributes[:slug])
        expect(response_hash['team_id']).to eql(@team.id)
      end
    end


    context 'User isn\'t a team member' do
      before :each do 
        @team = create(:team)
        @channel_attributes = attributes_for(:channel, team: @team)
        post :create, params: { channel: @channel_attributes.merge(team_id: @team.id) }
      end

      it 'should return http forbidden' do
        expect(response).to have_http_status(:forbidden)
      end
    end

  end

  describe 'GET #show' do
    # adding json rendering for the tests
    render_views

    context 'User is a team member' do
      before :each do
        team = create(:team, user: @current_user)
        @channel = create(:channel, team: team)

        @message1 = build(:message)
        @message2 = build(:message)

        @channel.messages << [ @message1, @message2 ]

        get :show, params: { id: @channel.id }
      end

      it 'should returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'should returns right values of the channel' do
        response_hash = JSON.parse(response.body)

        expect(response_hash['slug']).to eql(@channel.slug)
        exepct(response_hash['user_id']).to eql(@channel.user.id)
        expect(response_hash['team_id']).to eql(@channel.team.id)
      end

      it 'should returns the right number of messages' do
        response_hash = JSON.parse(response.body)
        expect(response_hash['messages'].count).to eql(2)
      end

      it 'should returns the right messages' do
        response_hash = JSON.parse(response.body)
        
        expect(response_hash['messages'][0]['body']).to eql(@message1.body)
        expect(response_hash['messages'][0]['user_id']).to eql(@message1.user.id)
        expect(response_hash['messages'][1]['body']).to eql(@message2.body)
        expect(response_hash['messages'][1]['user_id']).to eql(@message1.user.id)
      end
    end

    context 'User is not a team member' do
      it 'should returns http forbidden' do
        channel = create(:channel)
        get :show, params: { id: channel.id }

        expect(response).to have_http_status(:forbidden)
      end
    end

  end

  describe 'DELETE #destroy' do
    context 'User is a team member' do
      context 'User is the channel owner' do
        team = create(:team)
        team.users << @current_user
        channel = create(:channel, team: team, user: @current_user)

        delete :destroy, params: { id: channel.id }

        expect(response).to have_http_status(:success)
      end
    end

    context 'User is the team owner' do
      it 'should returns http success' do
        team = create(:team, user: @current_user)
        channel_owner: create(:user)

        team.users << channel_owner
        @channel = create(:channel, team: team, user: channel_user)

        delete :destroy, params: { id: channel.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'User is not the team or channel owner' do
      it 'should returns http forbidden' do
        team = create(:team)
        team.users << @current_user
        channel = create(:channel, team: team)

        delete :destroy, params: { id: channel.id }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'User is not a team member' do
      it 'should returns http forbidden' do
        team = create(:team)
        channel = create(:channel, team: team)

        delete :destroy, params: { id: channel.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

end