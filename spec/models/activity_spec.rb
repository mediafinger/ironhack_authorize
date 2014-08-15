require 'rails_helper'

describe Activity do

  describe "Task" do

    context "create" do
      let(:user)    { User.create(email: "mike@brown.com", password: "dontshoot") }
      let(:project) { Project.create(name: "hey ho") }

      it "should create an Activity" do
        task = Task.create(user: user, project: project, name: "Something", status: "todo")

        expect(Activity.where(task: task, user: user).first).to be
      end
    end

  end

end
