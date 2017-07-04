require 'rails_helper'

RSpec.describe City, type: :model do
  it { should validate_presence_of :eng_name }
  it { should validate_presence_of :rus_name }

  it { should have_many(:companies) }
end
