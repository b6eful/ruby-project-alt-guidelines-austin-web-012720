class User < ActiveRecord::Base
    def self.loginquestion
        prompt = TTY::Prompt.new
        prompt.yes?("Do you have a login?")
    end

    def self.username
        prompt = TTY::Prompt.new
        if self.loginquestion == true and returninguser == user.user_name
            returninguser = prompt.ask("Please enter Username")
            if
                returninguser == user.user_name
                password = prompt.mask("Please enter Password")
            end

        else
            username = prompt.ask("what do you want you username to be?") do |q|
                q.required true
                q.validate /\A\w+\Z/
                q.modify   :capitalize
            password = prompt.mask("Please create password")
            end
            user = User.new
            user.user_name = username
            user.password = password
            user.save()
        end
        # Exeucute Active Record Database Storage
        # get rid of user_id, get password all that working
    end

    def self.password
        prompt = TTY::Prompt.new
        if self.loginquestion == true 
            prompt.mask("ENTER PASSWORD")
        else
            prompt.mask("please create password")
        end

    end
end
