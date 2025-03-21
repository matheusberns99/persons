require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'verify if superclass of ApplicationJob is ActiveJob::Base' do
    expect(ApplicationJob.superclass).to eq(ActiveJob::Base)
  end
end
