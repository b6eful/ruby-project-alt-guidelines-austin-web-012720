# Start running linear methods from files.

require 'tty-prompt'


# this method is the starting screen ask you what user would like to do
def startup() 
    beginuser = TTY::Prompt.new
    beginseq = beginuser.select("Would you like to sign up or login?")do |menu|
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


    #this method logs you in, Prompt is created, checks if the var assoicated with the intial prompt equals a value thats in the db if it is associated then login
    #^if prompt is 
def login()
    prompt = TTY::Prompt.new
    username = prompt.ask("Please enter Username", required: true)
    if (User.where(name: username).length != 0)
        user = User.where(name: username)[0]
        login(user.id)
        end  
    elsif
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


def signup()
    prompt = TTY::Prompt.new
    name = prompt.ask("What would you like you username to be?", required: true)
    if 
        (User.where(name: name).length !=0)
        puts "That username is taken please choose another"
        signup()
    else
        user = User.create(name: name)
        login(user.id)
    end
end


#once user is signed in/ signed up
# prompt them with do you want to create model
#prompt with view past models

def signedin()
    prompt = TTY::Prompt.new
    if login(user.id) == true
        answer = prompt.choice("What would you like to do?", required: true) do |choices|
            choices.choice "Create Model", 1
            choices.choice "View past models", 2
        end

        case answer
        when 1
            mod_name = prompt.ask("Name your model", required: true)
            self.models.create(name: mod_name).make_model
        when 2
            if self.models.all.empty?
                puts "You dont have any models"
                signedin()
            else
                selection = prompt.enum_select("Select graph you wish to view:",self.models.all)
                File.open("../Graphs/#{selection.file_path}")
                signedin()
            end

        end
    end
end