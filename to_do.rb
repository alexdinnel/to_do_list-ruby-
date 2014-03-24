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
  until choice == 'x'
    puts "Press 'a' to add a task, 'l' to list your task, or 'd' to mark a task as done"
    puts "Press 'x' to exit"
    choice = gets.downcase.chomp
    case choice
    when 'a'
      add
    when 'l'
      list
    when 'd'
      done
    when 'x'
      exit
    else
      puts "You don't know what you are doing!! :)"
    end
  end
end

def add
  puts "What do you want to do?"
  task_name = gets.chomp
  task = Task.new(:name => task_name, :done => false)
  task.save
  puts "'#{task_name}' has been added to your To Do list."
end

def done
  puts 'Which of these tasks would you like to mark as done?'
  Task.all.each { |task| puts task.name}
  done_task_name = gets.chomp
  done_task = Task.where(:name => done_task_name).pop
  done_task.update_attributes(:done => true)
end

def list
  puts "Here is everything you need to do:"
  tasks = Task.not_done
  tasks.each { |task| puts task.name }
end

welcome
