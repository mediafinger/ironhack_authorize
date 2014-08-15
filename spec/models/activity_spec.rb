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

    context "update" do
      let(:user)    { User.create(email: "mike@brown.com", password: "dontshoot") }
      let(:project) { Project.create(name: "hey ho") }
      let!(:task)    { Task.create(user: user, project: project, name: "Something", status: "todo") }

      it "should create an Activity" do
        expect{task.update_attributes(status: "doing")}.to change{Activity.all.count}.by(1)
      end

      it "should create an Activity" do
        task.update_attributes(status: "doing")

        expect(Activity.last.action).to eq "updated"
      end
    end


  end

end
