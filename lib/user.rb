class User < ActiveRecord::Base
    def loginquestion
        prompt = TTY::Prompt.new
        prompt.yes?("Do you have a login?")
    end

    def self.username
        prompt = TTY::Prompt.new
        prompt.ask("what do you want you user name to be?") do |q|
            q.required true
            q.validate /\A\w+\Z/
            q.modify   :capitalize
        end
    end

    def self.password
        prompt = TTY::Prompt.new
        prompt.mask("please create password")
    end
end
