require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(5)}
  it { is_expected.to validate_presence_of(:password_confirmation) }


user1 = User.create({
  name: "Nolan",
  email: "123@email.com",
  password: "password",
  password_confirmation: "passwordtest"
})

user2 = User.create({
  name: "Nolan2",
  email: "123@email.com",
  password: "password",
  password_confirmation: "passwordtest"
})



it "should be invalid if passwords dont match" do
      expect(user1).to_not be_valid
    end

    it "should be invalid if email is the same as User1" do
      expect(user2).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do

    @user3 = User.create({
       name: "Nolan3",
       email: "123@email.com",
       password: "password",
       password_confirmation: "password"
    })

    it "should be valid if proper credentials given" do
      expect(user3.authenticate_user(user3.email, user3.password)).to eq(@user3)
      expect(user3.authenticate_user("123@email.com", user3.password)).to be_nil
      expect(user3.authenticate_user(user3.email, "invalid_password")).to be_nil
    end
  end

  describe "edge cases" do
    it "should be valid regardless of spacing" do
      user_spacing = User.create({
        name: "Nolan",
        email: "123@email.com",
        password: "password",
        password_confirmation: "password",
      })

      expect(user_spacing.authenticate_user("   123@email.com   ", user_spacing.password)).to eq(user_spacing)
    end

    it "should be valid regardless of case" do
      user_case = User.create({
        name: "Nolan",
        email: "123@email.com",
        password: "password",
        password_confirmation: "password",
      })

      expect(user_case.authenticate_user("123@eMaIl.cOm", user_case.password)).to eq(user_case)
    end

    it "should be valid in login regardless of case in the reverse" do
      user_reverse = User.create({
       name: "Nolan",
        email: "123@EMAIL.com",
        password: "password",
        password_confirmation: "password",
      })

      expect(user_reverse.authenticate_user("123@email.com", user_reverse.password)).to eq(user_reverse)
    end
  end
end

