require 'joe_utils'
require 'json'
require 'digest/sha2'

include FilesHelper

TALKS_PATH = '../data/talks.json'
USERS_PATH = '../data/users.json'

def run
  puts @talks['run_dialog']
  action = gets
end

def login
  puts @talks['login_username']
  username = gets
  puts @talks['login_password']
  if Digest::SHA512.hexdigest(gets) == @users[username]['password']
    @actual_user = username
  else
    puts @talks['unsuccessful_login']
  end
end

def signup
  puts @talks['signup_username']
  username = gets
  if @users[username]
    puts @talks['username_exists']
  else
    puts @talks['signup_password']
    @users[username]['password'] = Digest.SHA512.hexdigest(gets)
    @actual_user = username
    puts @talks['signed_up']
    run
  end
end

def process_input(input)
  case input
    when 'login'
      login
    when 'signup'
      signup
  end
end

begin
  @talks = JSON.parse(load_file_text(TALKS_PATH))
  @users = JSON.parse(load_file_text(USERS_PATH))
  puts @talks['welcome']
  puts @talks['help']
  process_input(gets)
end