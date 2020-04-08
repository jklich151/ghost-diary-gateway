require 'rails_helper'

RSpec.describe Day, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:week) }
    it { should validate_presence_of(:day_of_week) }
    it { should define_enum_for(:day_of_week).with_values([:Sunday, :Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday]) }
  end

  describe 'relationships' do
    it { should belong_to(:group) }
    it { should have_many(:posts) }
  end
end