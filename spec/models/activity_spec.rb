require 'rails_helper'

describe Activity do

  describe "Task" do

    context "create" do
      let(:user) { User.create(name: "Mike") }

      it "should create an Activity" do
        expect(Task.create(user: user, name: "Something", status: "todo")).to
          change { Activity.all.count }
      end
    end

  end

end
