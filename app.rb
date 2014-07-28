require 'rubygems'; require 'bundler'; Bundler.require
require 'ruby-debug'
require "sinatra/reloader" if development?

get '*' do
  return_answer
end

post '*' do
  return_answer
end

not_found do
  content_type :json
  {:answer => "I fell behind the desk!"}.to_json
end

ANSWERS = [
  "It is certain",
  "It is decidedly so",
  "Without a doubt",
  "Yes definitely",
  "You may rely on it",
  "As I see it, yes",
  "Most likely",
  "Outlook good",
  "Yes",
  "Signs point to yes",
  "Reply hazy try again",
  "Ask again later",
  "Better not tell you now",
  "Cannot predict now",
  "Concentrate and ask again",
  "Don't count on it",
  "My reply is no",
  "My sources say no",
  "Outlook not so good",
  "Very doubtful",
]

def return_answer
  content_type :json
  shakes = params[:shakes].to_i
  shakes = 8 if shakes == 0

  begin
    answer = get_answer(shakes)
  rescue ArgumentError => e
    answer = e.message
  rescue
    {:answer => "You broke me!"}.to_json and return
  end

  {:answer => answer}.to_json
end

def get_answer(shakes=8)
  raise ArgumentError, "Nice Try, Bub" if shakes <= 0
  raise ArgumentError, "Your robot arms are tired, somehow" if shakes >= 300
  shaken_results = []
  shakes.times{ shaken_results << ANSWERS.sample }
  return shaken_results.sample
end