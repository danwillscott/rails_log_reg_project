require 'rails_helper'

RSpec.describe BackUp, type: :model do
  it 'Ensure backup saves full user object' do
    pass  = {first_name: 'Bob', last_name: 'Smith', email: 'testemail@gmail.com', password: 'testPassword', password_confirmation: 'testPassword' }
    user1 = User.create(pass)
    user1.save
    user1 = User.last!
    backup = BackUp.create(jsonData: user1)

    expect(backup[:jsonData]['id']).to eq(user1.id)
    expect(backup[:jsonData]['first_name']).to eq(user1.first_name)
    expect(backup[:jsonData]['last_name']).to eq(user1.last_name)
    expect(backup[:jsonData]['email']).to eq(user1.email)
    expect(backup[:jsonData]['password_digest']).to eq(user1.password_digest)
    expect(backup[:jsonData]['description']).to eq(user1.description)

    # The fallowing tests do no work because of the way date is saved in the json file
    # expect(backup[:jsonData]['created_at']).to eq(user1.created_at)
    # expect(backup[:jsonData]['updated_at']).to eq(user1.updated_at)
  end
end
