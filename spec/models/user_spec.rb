require 'rails_helper'

describe User, type: :model do
  it "メールアドレス、パスワードがあれば有効な状態である" do
    user = User.new(email: "test@test.com", password: "password", name: "user")
    expect(user).to be_valid
  end

end
