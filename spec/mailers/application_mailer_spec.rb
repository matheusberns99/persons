require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it 'verify if ApplicationMailer superclass is ActionMailer::Base' do
    expect(ApplicationMailer.superclass).to eq(ActionMailer::Base)
  end

  it 'verify if from property has a default value' do
    expect(ApplicationMailer.default[:from]).to be_present
  end
end
