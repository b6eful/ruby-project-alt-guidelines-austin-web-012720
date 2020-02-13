class User < ActiveRecord::Base
has_many :models
has_many :models, through: :stocks
end











#     def self.loginquestion
#         prompt = TTY::Prompt.new
#         prompt.yes?("Do you have a login?", convert: :bool)
#     end

#     def self.username
#         prompt = TTY::Prompt.new
#         if self.loginquestion == true
#             returninguser = prompt.ask("Please enter Username")
#             if returninguser == users.user_name
#                 password = prompt.mask("Please enter Password")
#             else
#                 puts "Username not found"
#             end

#         else
#             username = prompt.ask("what do you want you username to be?") do |q|
#                 q.required true
#                 q.validate /\A\w+\Z/
#                 q.modify   :capitalize
#             end
#             password = prompt.mask("Please create password")
#             user = User.new
#             user.user_name = username
#             user.password = password
#             user.save()
#         end
#     end

#     def self.option
#         prompt = TTY::Prompt.new
#         userchoice = prompt.select("Search stock or see stocks youve searched") do |menu|
#             menu.choice 'Search Stock'
#             menu.choice 'Past Searches'
#         end
#     end

# end
