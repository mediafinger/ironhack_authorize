# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Example:

if Rails.env == "development"
  puts "Cleaning DB first ..."
  User.destroy_all
  Project.destroy_all
  Task.destroy_all
  Activity.destroy_all
end

PROJECTS = 10

puts "Creating Users ..."
User.create!(email: "ana@example.com",   password: "test", confirmed: true)
User.create!(email: "bella@example.com", password: "test", confirmed: true)
User.create!(email: "clara@example.com", password: "test", confirmed: true)
User.create!(email: "dora@example.com",  password: "test", confirmed: true)

puts "Creating Projects ..."
(1..PROJECTS).each do |index|
  Project.create!(name: "Project #{index}")
end

projects = Project.all.to_a
User.all.to_a.each do |user, index|
  (1..3).each do
    user.projects << projects.sample
  end

  puts "Creating Tasks ..."
  user.projects.each do |project|
    (1..rand(2..4)).each do |i|
      project.tasks.create!(name: "Task #{i}", status: %w(todo doing done).sample, user: user)
    end
  end
end
