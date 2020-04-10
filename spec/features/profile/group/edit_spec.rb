require "rails_helper"

RSpec.describe 'Profile/group edit page -' do
  describe 'Registered user' do
    describe 'without a group' do
      it 'can join a group' do
        Group.create(name: 'Mod 1')
        Group.create(name: 'Mod 2')
        Group.create(name: 'Mod 3')
        user = User.create(name: 'User', uid: '1111')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/'

        expect(page).to have_content("It seems you haven't joined a group yet.")
        click_button('Join a group now!')

        expect(current_path).to eq('/profile/group/edit')

        select 'Mod 1', :from => 'groupSelect'
        click_button('Join')

        expect(current_path).to eq('/posts')
        expect(page).to have_content('You have joined Mod 1!')
        expect(page).to_not have_content("It seems you haven't joined a group yet.")
      end
    end
  end
end