# Start running linear methods from files.
require_relative '../lib/user.rb'
require 'tty-prompt'


class Main < User
# this method is the starting screen ask you what user would like to do
  def startup()
      prompt = TTY::Prompt.new
      beginseq = prompt.select("Would you like to sign up or login?")do |menu|
      menu.default 1
      menu.choice 'Sign up', 1
      menu.choice 'Login', 2
  end
      #this is a if statment. If var beginseq is 1 then signup if 2 then login
      case beginseq
      when 1
          signup()
      when 2
          login()
       end
  end


  def signup()
      prompt = TTY::Prompt.new
      name = prompt.ask("What would you like your username to be?", required: true)
      if (User.where(name: name).length != 0)
          puts "That username is taken please choose another"
          signup()
      else
          user = User.create(name: name)
           x = true
           signedin(x,user)

      end
  end



    #this method logs you in, Prompt is created, checks if the var assoicated with the intial prompt equals a value thats in the db if it is associated then login
    #^if prompt is
  def login()
      prompt = TTY::Prompt.new
      username = prompt.ask("Please enter Username", required: true)
      if (User.where(name: username).length != 0)
          user = User.where(name: username)[0]
          x = true
          signedin(x,user)
      else
          second = prompt.select("Username does not exist", required: true) do |y|
            y.choice 'Sign Up', 1
            y.choice 'Try Again', 2
          end
          case second
          when 1
              signup()
          when 2
              login()
          end
      end

  end


  def signedin(x,user)
      if x == true

      prompt = TTY::Prompt.new
          answer = prompt.select("What would you like to do?", required: true) do |choices|
              choices.choice "Create Model", 1
              choices.choice "View past models", 2
              choices.choice "Exit Program", 3
          end

          case answer
          when 1
              mod_name = prompt.ask("Name your model", required: true)
              user.models.create(name: mod_name).make_model
              signedin(x,user)
          when 2
              if user.models.all.empty?
                  puts "You dont have any models"
                  signedin(x,user)
              else
                  selection = prompt.enum_select("Select graph you wish to view:",user.models.all, required: true)
                #  File.open("/Users/homepro/Development/code/ruby-project-alt-guidelines-austin-web-012720/lib/Graph/#{selection.file_path}")
                  system %{open "/Users/homepro/Development/code/ruby-project-alt-guidelines-austin-web-012720/lib/Graph/#{selection.file_path}"}
                  signedin(x,user)
              end
          when 3
              return "Exit succesful"
          end
      end
  end
end
