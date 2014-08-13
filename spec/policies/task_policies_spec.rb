require 'rails_helper'

describe TaskPolicy do
  subject { TaskPolicy.new(user, task) }

  context "for a developer" do
    let(:user)    { User.create!(email: "test@example.com", password: "test", confirmed: true, roles: ["developer"]) }
    let(:project) { Project.create!(name: "Project 1") }
    let(:task)    { user.tasks.create(name: "Task 1", status: "todo", project: project) }

    it { should     permit(:show)    }
    it { should     permit(:create)  }
    it { should     permit(:new)     }
    it { should     permit(:update)  }
    it { should     permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for a po" do
    let(:user)    { User.create!(email: "test@example.com", password: "test", confirmed: true, roles: ["po"]) }
    let(:project) { Project.create!(name: "Project 1") }
    let(:task)    { user.tasks.create(name: "Task 1", status: "todo", project: project) }

    it { should     permit(:show)    }
    it { should     permit(:create)  }
    it { should     permit(:new)     }
    it { should     permit(:update)  }
    it { should     permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for an admin" do
    let(:user)    { User.create!(email: "test@example.com", password: "test", confirmed: true, roles: ["admin"]) }
    let(:project) { Project.create!(name: "Project 1") }
    let(:task)    { user.tasks.create(name: "Task 1", status: "todo", project: project) }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
end
