require 'rails_helper'

RSpec.describe Email, type: :model do
  it { should validate_presence_of :value }

  it { should belong_to(:company) }
end
