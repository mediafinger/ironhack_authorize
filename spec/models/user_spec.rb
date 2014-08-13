require 'rails_helper'

describe User do

  describe "Roles" do
    describe "when validating the roles" do
      let!(:user) { User.new(email: "name@example.com", password: "password") }

      it "allows developer" do
        expect(user.valid?).to eq true
      end

      it "allows po" do
        user.roles << "po"
        expect(user.valid?).to eq true
      end

      it "allows admin" do
        user.roles << "admin"
        expect(user.valid?).to eq true
      end

      it "allows a user without role" do
        user.roles -= ["developer"]
        expect(user.valid?).to eq true
      end

      it "does not permit a duplicated role" do
        user.roles << "developer"
        expect(user.valid?).to eq false
      end

      it "does not permit an unknown role" do
        user.roles << "designer"
        expect(user.valid?).to eq false
      end
    end

    describe "when adding a role" do
      let!(:user) { User.new(email: "name@example.com", password: "password") }

      it "allows po" do
        expect(user.add_role("po")).to eq true
      end

      it "allows admin" do
        expect(user.add_role("admin")).to eq true
      end

      it "allows developer" do
        user.remove_role("developer")  # "developer" is the default role
        expect(user.add_role("developer")).to eq true
      end

      it "does not permit a duplicated role" do
        expect { user.add_role("developer") }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "does not permit an unknown role" do
        expect { user.add_role("designer") }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe "when removing a role" do
      let!(:user) { User.new(email: "name@example.com", password: "password") }

      it "allows po" do
        expect(user.remove_role("po")).to eq true
      end

      it "allows admin" do
        expect(user.remove_role("admin")).to eq true
      end

      # this validation is not implemented yet
      it "does not permit removing the last role" do
        expect(user.remove_role("developer")).to raise_error(ActiveRecord::RecordInvalid)
      end

      it "does not care about unknown roles" do
        expect(user.remove_role("designer")).to eq true
      end
    end

    describe "when checking a user for the role" do
      let!(:user) { User.new(email: "name@example.com", password: "password") }

      context "admin" do
        it "is false" do
          expect(user.admin?).to eq false
        end

        it "is true" do
          user.add_role("admin")
          expect(user.admin?).to eq true
        end
      end

      context "developer" do
        # developer is default value - this is tested here implicitly
        it "is false" do
          user.remove_role("developer")
          expect(user.developer?).to eq false
        end

        it "is true" do
          expect(user.developer?).to eq true
        end
      end

      context "po" do
        it "is false" do
          expect(user.po?).to eq false
        end

        it "is true" do
          user.add_role("po")
          expect(user.po?).to eq true
        end
      end
    end
  end


  describe "when ensuring that the user model is valid" do
    # User objects usually have many fields... so better create a user factory!
    before do
      @user = User.new(email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    end

    # the one liners will all test the subject
    subject { @user }

    # one-liner syntax - here the "should" can still be used with Rspec 3
    # the first example is equal to:
    # it { is_expected.to respond_to(:email) }
    # decide yourself if you like more consistency (using expect) or the shorter should

    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    it { should be_valid }
  end


  describe "when password is not present" do
    before do
      @user = User.new(email: "user@example.com", password: " ", password_confirmation: " ")
    end

    # same test in one-liner syntax
    it { should_not be_valid }

    # same test in more verbose block syntax
    it "should not be valid" do
      expect(@user).to_not be_valid
    end
  end


  describe "when password doesn't match confirmation" do
    # using let instead of before block - just for demonstration, you should be consistent ;-)
    let(:user) { User.new(email: "user@example.com", password: "123456", password_confirmation: " ") }

    before { user.password_confirmation = "mismatch" }

    it { should_not be_valid }
  end


  describe "Email Validations" do
    context "on a new user" do
      it "should not be valid without a email" do
        user = User.new(email: nil, password: "password", password_confirmation: "password")
        expect(user).to_not be_valid
      end

      it "should be not be valid" do
        user = User.new(email: "not.anE-mail", password: "password", password_confirmation: "password")
        expect(user).to_not be_valid
      end

      it "should not be valid" do
        user = User.new(email: "test@example", password: "password", password_confirmation: "password")
        expect(user).to_not be_valid
      end

      it "should be valid" do
        user = User.new(email: "test.1234+gmail@example.env.far-away.museum", password: "password", password_confirmation: "password")
        expect(user).to be_valid
      end
    end

    context "when an existing user is modified" do
      let(:user) do
        User.create(email: "test@example.com", password: 'password', password_confirmation: 'password')
      end

      it "user should be valid" do
        expect(user).to be_valid
      end

      it "should not be valid with an empty email" do
        user.email = nil
        expect(user).to_not be_valid
      end

      it "should be valid with a string that is no valid email" do
        user.email = "not.an.email"
        expect(user).to_not be_valid
      end

      it "should be valid" do
        user.email = "ha@db.de"
        expect(user).to be_valid
      end
    end
  end


  describe "Password Validations" do
    context "when a new user is created" do
      it "should not be valid without a password" do
        user = User.new(email: "test@example.com", password: nil, password_confirmation: nil)
        expect(user).to_not be_valid
      end

      it "should be not be valid with a short password" do
        user = User.new(email: "test@example.com", password: '1', password_confirmation: '1')
        expect(user).to_not be_valid
      end

      it "should not be valid with a confirmation mismatch" do
        user = User.new(email: "test@example.com", password: 'short', password_confirmation: 'long')
        expect(user).to_not be_valid
      end
    end

    context "when an existing user is modified" do
      let(:user) do
        User.create(email: "test@example.com", password: 'password', password_confirmation: 'password')
      end

      it "user should be valid" do
        expect(user).to be_valid
      end

      it "should not be valid with an empty password" do
        user.password = user.password_confirmation = ""
        expect(user).to_not be_valid
      end

      it "should be valid with a new (valid) password" do
        user.password = user.password_confirmation = "new password"
        expect(user).to be_valid
      end
    end
  end
end
