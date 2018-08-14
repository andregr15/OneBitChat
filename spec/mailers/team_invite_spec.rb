require "rails_helper"

RSpec.describe TeamInviteMailer, type: :mailer do
  describe "invitation" do
    before do 
      @user = create(:user)
      @team = create(:team, user: @user)
      @user1 = create(:user)

      @mail = TeamInviteMailer.invitation(@team, @user1)
    end
    
    it 'should renders the headers' do
      expect(@mail.subject).to eq("Invitation to team #{@team.slug}")
      expect(@mail.to).to eq([@user1.email])
    end

    it 'should have the team name in the body' do
      expect(@mail.body.encoded).to match(@team.slug)
    end

    it 'should have the user name in the body' do
      expect(@mail.body.encoded).to match(@user1.name)
    end

    it 'should have the link to user accepts the invitation' do
      expect(@mail.body.encoded).to match("/team/#{@team.id}/team_users/#{@user1.id}")
    end
  end

end
