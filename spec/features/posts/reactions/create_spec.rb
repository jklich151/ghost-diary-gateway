require 'rails_helper'

RSpec.describe 'Post show -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group)
      user = create(:user, group: group_1)
      poster = create(:user, group: group_1)
      day_1 = create(:day, group: group_1)
      day_2 = create(:day, group: group_1)
      day_3 = create(:day, group: group_1)
      3.times {
        create(:post, day: day_1, user: poster)
        create(:post, day: day_2, user: poster)
        create(:post, day: day_3, user: poster)
      }
      @post = create(:post, day: day_1, user: poster)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit post_path(@post)
    end

    it 'can react to a post' do
      click_button('Like')

      expect(current_path).to eq(post_path(@post))
      expect(page).to_not have_button('Like', count: 1)
      expect(page).to have_button('Undo like', count: 1)
    end
  end
end