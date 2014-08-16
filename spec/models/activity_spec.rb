require 'rails_helper'

describe Activity do

  describe "Task" do
      let(:user)    { User.create(email: "mike@brown.com", password: "dontshoot") }
      let(:project) { Project.create(name: "hey ho") }

    context "create" do
      before { Task.create(user: user, project: project, name: "Something", status: "todo") }

      it "should create an Activity" do
        expect(Activity.where(user_id: user.id).first).to be
      end

      it "should create an Activity for created" do
        expect(Activity.last.action).to eq "created"
      end
    end

    context "update" do
      let!(:task)   { Task.create(user: user, project: project, name: "Something", status: "todo") }

      it "should create an Activity" do
        expect{task.update_attributes(status: "doing")}.to change{Activity.all.count}.by(1)
      end

      it "should create an Activity for updated" do
        task.update_attributes(status: "doing")

        expect(Activity.last.action).to eq "updated"
      end
    end

    context "delete" do
      let!(:task)   { Task.create(user: user, project: project, name: "Something", status: "todo") }

      it "should create an Activity" do
        expect{task.destroy}.to change{Activity.all.count}.by(1)
      end

      it "should create an Activity for deleted" do
        task.destroy

        expect(Activity.last.action).to eq "deleted"
      end
    end
  end


 describe "Project" do
      let(:user)    { User.create(email: "mike@brown.com", password: "dontshoot") }

    context "create" do
      before { Project.create(name: "hey ho") }

      it "should create an Activity for item_type project" do
        expect(Activity.last.item_type).to eq "project"
      end

      it "should create an Activity for created" do
        expect(Activity.last.action).to eq "created"
      end
    end

    context "delete" do
      let!(:project) { Project.create(name: "hey ho") }

      it "should create an Activity" do
        expect{project.destroy}.to change{Activity.all.count}.by(1)
      end

      it "should create an Activity for deleted" do
        project.destroy

        expect(Activity.last.action).to eq "deleted"
      end
    end
  end

end
