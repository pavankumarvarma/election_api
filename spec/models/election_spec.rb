require 'rails_helper'

RSpec.describe Election, :type => :model do
  it "is not valid with valid attributes and without group" do
    expect(Election.new).to_not be_valid
  end

  it "is not valid without a name" do
    election = Election.new(name: nil)
    expect(election).to_not be_valid
  end
  it "is not valid without a category" do
    election = Election.new(category: nil)
    expect(election).to_not be_valid
  end
 
end