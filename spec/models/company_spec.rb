require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of :site }

  it { should have_many(:phones) }
  it { should have_many(:emails) }

  it { should belong_to(:category) }
  it { should belong_to(:city) }
end
