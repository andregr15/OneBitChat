require 'rails_helper'

RSpec.describe SendMailJob, type: :job do
  describe "#perform_later" do
    before do
      @team = create(:team)
      @user = create(:user)
    end
    
    it 'should send a invitation e-mail' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SendMailJob.new(@team, @user).perform
      }.to enqueue_job
    end
  end
end