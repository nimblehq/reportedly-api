require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user_instance }

  let(:user_instance) { Fabricate(:user) }

  it { is_expected.to validate_presence_of :slack_id }
end
