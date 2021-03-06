require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:uid) }
    it { should define_enum_for(:role).with_values([:admin, :registered_user]) }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
    it { should have_many(:reactions) }
    it { should belong_to(:group).optional(true) }
  end

  describe 'methods' do
    it 'post_count' do
      group_1 = Group.create(name: 'Mod 1')
      user = User.create(name: 'user', uid: '1111', group: group_1)
      day_1 = Day.create(week: 1, day_of_week: 1, group: group_1)
      day_2 = Day.create(week: 2, day_of_week: 5, group: group_1)
      day_3 = Day.create(week: 4, day_of_week: 3, group: group_1)
      day_4 = Day.create(week: 6, day_of_week: 4, group: group_1)
      Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: day_1, user: user)
      Post.create(body: "Just took my first in class challenge. I'm NEVER going to get any better at this!!", tone: "angry", day: day_2, user: user)
      Post.create(body: "Learning that I gotta utilize my resources and getting better doesn't come out of thin air. Make sure to use paired.tech!!", tone: "optimistic", day: day_3, user: user)
      Post.create(body: "Passed Mod 1!! Time to get schwifty with the Turing crew", tone: "excited", day: day_4, user: user)
      expect(user.post_count).to eq(4)
    end
  end
end
