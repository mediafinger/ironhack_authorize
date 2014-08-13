class ProjectStatisticsService
  require 'csv'

  def initialize(projects)
    @projects = projects
  end

  def csv
    stats = CSV.generate(:col_sep => ",") do |csv|
      csv << %w[Name, Status, Tasks, Users]     # CSV HEADER

      data.each { |project| csv << project }   # Rows with data
    end

    stats
  end

  private

  def data
    stats = []

    @projects.each do |project|
      stats << [project.name, project.status, project.tasks.count, project.users.count]
    end

    stats
  end

end
