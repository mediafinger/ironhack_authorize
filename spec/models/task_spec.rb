require 'rails_helper'

# When naming the "describe", "context" and "it" parts of your test,
# try to make the output as readable as possible. This will usually
# convey the meaning of your tests best.
# For this tests the output will read like this: (note that the order is random!)
# Task
#   when validating the status
#     it should succeed when
#       todo is given
#       doing is given
#       done is given
#     it should fail when
#       no status is given
#       nil is given as a status
#       a status is given that is not todo, doing or done
#   when validating the name
#     it should succeed when
#       a name is given
#     it should fail when
#       no name is given

describe Task do

  # group your tests with "describe" - e.g. for each method you test
  describe "when validating the status" do

    # define instance varibles with "let"
    # read about the difference of the lazy "let" and the eager "let!""
    let(:project) { Project.create(name: "p 1") }
    let(:user)    { User.create(email: "ana@example") }

    # alternately or additionally you can use "before do" blocks
    before do
      user.projects << project
    end

    # sub-group your tests with "context" in logical blocks - e.g. in success and failure cases
    context "it should succeed when" do
      it "todo is given" do
        task = project.tasks.create!(user: user, name: "t 1", status: "todo")
        expect(task.valid?).to be true
      end

      it "doing is given" do
        task = project.tasks.new(user: user, name: "t 1", status: "doing")
        expect(task.valid?).to be true
      end

      it "done is given" do
        task = project.tasks.new(user: user, name: "t 1", status: "done")
        expect(task.valid?).to be true
      end
    end

    context "it should fail when" do
      it "no status is given" do
        task = project.tasks.new(user: user, name: "t 1")
        expect(task.valid?).to be false
      end

      it "nil is given as a status" do
        task = project.tasks.new(user: user, name: "t 1", status: nil)
        expect(task.valid?).to be false
      end

      it "a status is given that is not todo, doing or done" do
        task = project.tasks.new(user: user, name: "t 1", status: "FAIL")
        expect(task.valid?).to be false
      end
    end
  end


  # just to make this example complete:
  describe "when validating the name" do

    # as we use the same "lets" and "before do" blocks in both "describes",
    # we could define them one level higher (directly beneath Task)
    let(:project) { Project.create(name: "p 1") }
    let(:user)    { User.create(email: "ana@example") }

    before do
      user.projects << project
    end

    # sub-group your tests with "context" in logical blocks - e.g. in success and failure cases
    context "it should succeed when" do
      it "a name is given" do
        task = project.tasks.create!(user: user, name: "Here I am!!", status: "todo")
        expect(task.valid?).to be true
      end
    end

    context "it should fail when" do
      it "no name is given" do
        task = project.tasks.new(user: user, status: "todo")
        expect(task.valid?).to be false
      end
    end
  end

end
