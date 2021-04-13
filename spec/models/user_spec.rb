require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
    expect(User.new).to be_valid
  end

  it "is valid without a name" do
    user = User.new(name: nil)
    expect(user).to be_valid
  end
  it "is valid without a email" do
    user = User.new(email: nil)
    expect(user).to be_valid
  end
 
end