namespace :statistics do

  desc "Statistics of Projects"
  task :projects => :environment do
    # TODO replace "puts" with file.csv creation
    puts ProjectStatisticsService.new(Project.all).csv
  end
end
