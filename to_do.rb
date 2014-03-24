require 'active_record'
require './lib/task'

database_configuration = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configuration["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the to do list"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a task, 'l' to list your task, or 'd' to mark a task as done"
  end
end
