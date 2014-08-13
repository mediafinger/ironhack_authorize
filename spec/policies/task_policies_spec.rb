require 'rails_helper'

describe TaskPolicy do
  # all the tests run on this subject - in every context block we define "user" and "task" a bit different
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

  context "for a po on tasks of another user" do
    let(:user)    { User.create!(email: "test@example.com", password: "test", confirmed: true, roles: ["po"]) }
    let(:dev)     { User.create!(email: "dev@example.com", password: "test", confirmed: true, roles: ["developer"]) }
    let(:project) { Project.create!(name: "Project 1") }
    let(:task)    { dev.tasks.create(name: "Task 2", status: "todo", project: project) }

    it { should     permit(:show)    }
    it { should_not permit(:create)  }  # fix the policy
    it { should_not permit(:new)     }  # fix the policy
    it { should_not permit(:update)  }  # write the test in another way
    it { should_not permit(:edit)    }  # write the test in another way
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

  context "for an admin on tasks of another user" do
    let(:user)    { User.create!(email: "test@example.com", password: "test", confirmed: true, roles: ["admin"]) }
    let(:dev)     { User.create!(email: "dev@example.com", password: "test", confirmed: true, roles: ["developer"]) }
    let(:project) { Project.create!(name: "Project 1") }
    let(:task)    { dev.tasks.create(name: "Task 2", status: "todo", project: project) }

    it { should     permit(:show)    }
    it { should_not permit(:create)  }  # fix the policy
    it { should_not permit(:new)     }  # fix the policy
    it { should     permit(:update)  }
    it { should     permit(:edit)    }
    it { should     permit(:destroy) }
  end
end
