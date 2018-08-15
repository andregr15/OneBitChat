require "rails_helper"

RSpec.describe TeamInviteMailer, type: :mailer do
  describe "invitation" do
    before do 
      @team = create(:team)
      @invite = create(:invite, team: @team)

      @mail = TeamInviteMailer.invitation(@invite)
    end
    
    it 'should renders the headers' do
      expect(@mail.subject).to eq("Invitation to team #{@invite.team.slug}")
      expect(@mail.to).to eq([@invite.email])
    end

    it 'should have the team name in the body' do
      expect(@mail.body.encoded).to match(@invite.team.slug)
    end

    it 'should have the user name in the body' do
      expect(@mail.body.encoded).to match(@invite.team.user.name)
    end

    it 'should have the link to user accepts the invitation' do
      expect(@mail.body.encoded).to match("/invitations/#{@invite.token}")
    end
  end

end
