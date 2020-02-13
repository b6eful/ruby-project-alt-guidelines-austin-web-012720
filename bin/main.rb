# Start running linear methods from files.

require 'tty-prompt'

def startup()
    beginuser = TTY::Prompt.new
    beginseq = beginuser.select("Would you like to sign up or login?")do |menu|
    menu.default 1
    menu.choice 'Sign up', 1
    menu.choice 'Login', 2
end


    case beginseq
    when 1
        signup()
    when 2
        login()
     end
end


def login()
    prompt = TTY::Prompt.new
    username = prompt.ask("Please enter Username")
    if (User.where(user_name: username).length != 0)
        user = User.where(user_name: username)[0]
        login(user.id)
    else
        reprompt = TTY::Prompt.new
        second = reprompt.select("Please choose") do |y|
          y.choice 'Sign Up', 1
          y.choice 'Try Again', 2
        end
    end

    case second
    when 1
        signup()
    when 2
        login()
    end
end


def signup()
    signuprompt = TTY::Prompt.new
    name = signuprompt.ask("What would you like you username to be?")
    if 
        (User.where(user_name: name).length !=0)
        puts "That username is taken please choose another"
        signup()
    else
        User.create(user_name: name)
    end
end
