require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @pass  = {first_name: 'Daniel', last_name: 'Scott', email: 'danwillscott@gmail.com',
              password: '7599black', password_confirmation: '7599black' }
    @fail1 = {last_name: 'Scott', email: 'danwillscott@gmail.com',
              password: '7599black', password_confirmation: '7599black' }
    @fail2 = {first_name: 'Daniel', email: 'danwillscott@gmail.com',
              password: '7599black', password_confirmation: '7599black' }
    @fail3 = {first_name: 'Daniel', last_name: 'Scott', email: 'danwillscott',
              password: '7599black', password_confirmation: '7599black' }
    @fail4 = {first_name: 'Daniel', last_name: 'Scott', email: 'danwillscott@gmail.com',
              password: 'black', password_confirmation: 'black' }
    @fail5 = {first_name: 'Daniel', last_name: 'Scott', email: 'danwillscott@gmail.com',
              password: '7599black', password_confirmation: 'black' }
    @login = {password: '7599black', email: 'danwillscott@gmail.com'}
  end
  it 'Ensure first_name validation' do
    user = User.register(@fail1)

    expect(user.save).to eq(false)
    expect(user.errors.full_messages).to eq(["First name can't be blank", 'First name is too short (minimum is 2 characters)'])
  end
  it 'Ensure last_name validation' do
    user = User.register(@fail2)

    expect(user.save).to eq(false)
    expect(user.errors.full_messages).to eq(["Last name can't be blank", 'Last name is too short (minimum is 2 characters)'])
  end
  it 'Ensure email unique validation' do
    user = User.register(@pass)
    user.save
    user = User.register(@pass)

    expect(user.save).to eq(false)
    expect(user.errors.full_messages).to eq(['Email has already been taken'])
  end
  it 'Ensure email regex validation' do
    user = User.register(@fail3)
    expect(user.save).to eq(false)
    expect(user.errors.full_messages).to eq(['Email is invalid'])
  end
  it 'Ensure password length validation' do
    user = User.register(@fail4)

    expect(user.save).to eq(false)
    expect(user.errors.full_messages).to eq(['Password is too short (minimum is 6 characters)'])
  end
  it 'Test password confirm does not match fail' do
    user = User.register(@fail5)

    expect(user.save).to eq(false)
    expect(user.password_confirmation).to eq('black')
    expect(user.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
  end
  it 'Ensure login method' do
    User.destroy_all
    user = User.register(@pass)

    expect(user.errors.full_messages).to eq([])
    expect(user.save).to eq(true)
    user = User.log_in(@login)

    expect(user[:first_name]).to eq('Daniel')
    expect(user[:last_name]).to eq('Scott')
    expect(user[:email]).to eq('danwillscott@gmail.com')
    expect(user[:truth]).to eq(true)
    expect(user[:id]).to be_a_kind_of(Integer)
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end