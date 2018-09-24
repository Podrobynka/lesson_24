require 'rubygems'
require 'sinatra'
# require 'sinatra/reloader'

get '/' do
  erb :main
end

post '/' do
  erb :main
  @login = params[:login]
  @password = params[:password]

  if @login == 'admin' && @password == 'secret'
    @users = File.readlines('public/userlist.txt')
    erb :users
  else
    @message = 'Access denied!'
  end
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  f = File.open('public/userlist.txt', 'a')
  f.write "\nUser: #{@username}. Phone: #{@phone}. Date and time: #{@datetime}. Barber: #{@barber}. Color: #{@color}"
  f.close

  if @username && @phone && @datetime
    @title = 'Thank you!'
    @message = "Dear #{@username}, we'll waiting f you at #{@datetime}."
    erb :visit
  end
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email = params[:email]
  @text = params['text']

  f = File.open('public/contacts.txt', 'a')
  f.write "\n#{@email} - #{@text}"
  f.close
end
