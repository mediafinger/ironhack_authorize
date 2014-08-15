class ProjectsController < ApplicationController

  after_action  :verify_authorized,    except: :index
  after_action  :verify_policy_scoped, only:   :index

  def index
    @projects = policy_scope(Project.all)  # Project.all is a scope

    if params[:status].present?
      @projects = @projects.select { |project| project.status == params[:status] }
    end
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project

    if @project.save
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      render :new
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project].permit(:name)
    end
end
